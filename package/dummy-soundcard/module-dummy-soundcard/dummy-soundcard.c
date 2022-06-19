/*
 * ASoC Driver for the Deqx digital board (machine driver file)
 *
 *  Created on: 2021-02-10
 *      Author: flatmax@flatmax.org
 *              based on the Audio Injector woffer project machine driver file
 *
 * Copyright (C) 2016-2021 Deqx Pty. Ltd.,Flatmax Pty. Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 */

#include <linux/module.h>
#include <linux/types.h>

#include <sound/core.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/pcm_params.h>
#include <sound/control.h>
//#include <linux/of_gpio.h>

//#include "../drivers/gpio/gpiolib.h"

struct deqx_digi_rk3399 {
	unsigned int mclk_48k;
	unsigned int mclk_44k;
};

SND_SOC_DAILINK_DEFS(digitalB,
		     // DAILINK_COMP_ARRAY(COMP_CPU("src4xxx-portA")),
		     // DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "src4xxx-portB")));
				 DAILINK_COMP_ARRAY(COMP_EMPTY()),
		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "src4xxx-portB")),
		     DAILINK_COMP_ARRAY(COMP_EMPTY()));

static struct snd_soc_dai_link deqx_digi_dais[] = {
	{
		.name = "Deqx Digi B",
		.stream_name = "Deqx Digi B",
		.dai_fmt = SND_SOC_DAIFMT_CBS_CFS|SND_SOC_DAIFMT_I2S|SND_SOC_DAIFMT_NB_NF,
		SND_SOC_DAILINK_REG(digitalB),
	},
};

static struct snd_soc_card snd_soc_deqx_digi_card = {
	.name = "deqx-digi-soundcard",
	.owner = THIS_MODULE,
	.dai_link = deqx_digi_dais,
	.num_links = ARRAY_SIZE(deqx_digi_dais),
};

static struct snd_soc_dai_link_component dummy_codec[] = {
	{
		.name = "snd-soc-dummy",
		.dai_name = "snd-soc-dummy-dai",
	}
};

static int deqx_digi_probe(struct platform_device *pdev)
{
	struct snd_soc_card *card = &snd_soc_deqx_digi_card;
	struct deqx_digi_rk3399 *deqx_digi_rk3399;

	int ret;

	dev_info(&pdev->dev, "deqx_digi_probe enter\n");

	deqx_digi_rk3399 = devm_kzalloc(&pdev->dev, sizeof(*deqx_digi_rk3399), GFP_KERNEL);
	if (!deqx_digi_rk3399)
		return -ENOMEM;

	dev_set_drvdata(&pdev->dev, deqx_digi_rk3399);
	snd_soc_card_set_drvdata(card, deqx_digi_rk3399);

	deqx_digi_dais[0].platforms->of_node = of_parse_phandle(pdev->dev.of_node,
							"i2s-controller", 0);

	if (deqx_digi_dais[0].platforms->of_node) {
		deqx_digi_dais[0].cpus->of_node = deqx_digi_dais[0].platforms->of_node;
		// deqx_digi_dais[1].platforms->of_node = deqx_digi_dais[0].platforms->of_node;
		// deqx_digi_dais[1].cpus->of_node = deqx_digi_dais[0].cpus->of_node;
	} else {
		dev_err(&pdev->dev, "Property 'i2s-controller' missing or invalid\n");
		return -EINVAL;
	}

	// deqx_digi_dais[0].codecs->of_node = of_parse_phandle(pdev->dev.of_node,
	// 		"deqx,digi-codec", 0);
	// if (!deqx_digi_dais[0].codecs->of_node) {
	// 	dev_err(&pdev->dev, "Property 'deqx,digi-codec' missing or invalid\n");
	// 	goto err_freeup_nodes;
	// }

	deqx_digi_dais[0].codecs->dai_name	= "snd-soc-dummy-dai";
	deqx_digi_dais[0].codecs->name		= "snd-soc-dummy";

	/* Look for external master clock specifications */

	card->dev = &pdev->dev;
	platform_set_drvdata(pdev, card);

	if ((ret = devm_snd_soc_register_card(&pdev->dev, card))){
		if (-ret==EPROBE_DEFER)
			dev_info(&pdev->dev, "deqx_digi_probe deferring exit ret=%d\n",ret);
		else
			dev_info(&pdev->dev, "deqx_digi_probe ERROR exit ret=%d\n",ret);
		return dev_err_probe(&pdev->dev, ret, "deqx_digi_probe exit\n");
	}
	dev_info(&pdev->dev, "deqx_digi_probe exit\n");
	return ret;

	err_freeup_nodes:
		if (deqx_digi_dais[0].platforms->of_node){
			of_node_put(deqx_digi_dais[0].platforms->of_node); // free up the i2s_node
		}
		if (deqx_digi_dais[0].codecs->of_node) {
			of_node_put(deqx_digi_dais[0].codecs->of_node);
		}
		return ret;
}

static int deqx_digi_remove(struct platform_device *pdev)
{
	struct snd_soc_card *card = platform_get_drvdata(pdev);
	struct deqx_digi_rk3399 *deqx_digi_rk3399 = snd_soc_card_get_drvdata(card); // null pointer

	dev_info(&pdev->dev, "deqx_digi_remove enter\n");

	if (deqx_digi_dais[0].platforms->of_node){
		of_node_put(deqx_digi_dais[0].platforms->of_node); // free up the i2s_node
		// deqx_digi_dais[1].platforms->of_node = deqx_digi_dais[0].platforms->of_node = NULL;
		// deqx_digi_dais[1].cpus->of_node = deqx_digi_dais[0].cpus->of_node = NULL;
	}
	if (deqx_digi_dais[0].codecs->of_node) {
		of_node_put(deqx_digi_dais[0].codecs->of_node);
		// deqx_digi_dais[1].codecs->of_node = deqx_digi_dais[0].codecs->of_node = NULL;
	}

	snd_soc_unregister_card(card);

	return 0;
}

static const struct of_device_id deqx_digi_of_match[] = {
	{ .compatible = "deqx,deqx-digi", },
	{},
};
MODULE_DEVICE_TABLE(of, deqx_digi_of_match);

static struct platform_driver deqx_digi_driver = {
	.driver         = {
		.name   = "deqx-digi",
		.owner  = THIS_MODULE,
		.of_match_table = deqx_digi_of_match,
	},
	.probe          = deqx_digi_probe,
	.remove          = deqx_digi_remove,
};

module_platform_driver(deqx_digi_driver);
MODULE_AUTHOR("Matt Flax <flatmax@flatmax.org>");
MODULE_DESCRIPTION("Deqx Digital Board");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:deqx-digi-rk3399");
