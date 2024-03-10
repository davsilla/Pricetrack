INSERT INTO "stores" ("id", "name", "url") VALUES
('ecb0edd7-a61f-4e52-840b-72b746550120',	'Amazon',	'https://amazon.com'),
('1d65acad-e3af-407f-84b0-69658b5c8979',	'BestBuy',	'https://bestbuy.com'),
('5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'newegg',	'https://newegg.com'),
('815a18fe-fbb2-4259-9380-b34c5d97b6c1',	'Walmart',	'https://walmart.com'),
('034d5e40-347c-414b-a004-25ec4f86b5ab',	'B&H',	'https://www.bhphotovideo.com');

INSERT INTO "info" ("id", "name", "brand", "model", "image_url", "interest") VALUES
('f8407af0-8f4d-4191-9130-ad274b28fd08',	'SanDisk 4TB Extreme Portable SSD Up to 1050MB/s - USB-C, USB 3.2 Gen 2 - External Solid State Drive - SDSSDE61-4T00-G25',	'SanDisk',	'SDSSDE61-4T00-G25',	'https://m.media-amazon.com/images/I/61zuR3UMnWL._AC_SL1500_.jpg',	0),
('44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a',	'Samsung - 990 PRO 4TB Internal SSD PCle Gen 4x4 NVMe',	'Samsung',	'MZ-V9P4T0B/AM',	'https://m.media-amazon.com/images/I/81WuG6lQuDL._AC_SL1500_.jpg',	0),
('f2311244-5de6-4d0a-aa9e-26e07a45cfe8',	'LG 55" Class 4K UHD OLED Web OS Smart TV with Dolby Vision C3 Series',	'LG',	'OLED55C3PUA',	'https://m.media-amazon.com/images/I/71O7wgely5L._AC_SL1500_.jpg',	0),
('08b67f91-eb81-4fbc-8aaa-4f2b028e9a67',	'Canon EOS Rebel T7 DSLR Camera with 18-55mm Lens',	'Cannon',	'2727C002',	'https://static.bhphoto.com/images/images500x500/1550657171_1461734.jpg',	0),
('7494904b-dd8e-4b4a-8450-d2dddd557a43',	'NVIDIA - GeForce RTX 4070 SUPER 12GB GDDR6X Graphics Card',	'Nvidia',	'900-1G141-2534-000',	'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6570/6570226cv1d.jpg',	0),
('f48eff6f-29fd-4653-9de5-6b8afae376c3',	'Wacom Intuos Graphics Drawing Tablet',	'Wacom',	'CTL4100 ',	'https://m.media-amazon.com/images/I/61UUcHcXWIL._AC_SL1500_.jpg',	0),
('9bec438a-1e43-4b28-8ce9-33d62c12b888',	'WD Black 10TB Performance Desktop Hard Disk Drive - 7200 RPM SATA 6Gb/s 256MB Cache 3.5 Inch ',	'Western Digital',	'WD101FZBX-SPATAA0',	'https://m.media-amazon.com/images/I/714xDSJWrkL._AC_SL1500_.jpg',	0);

INSERT INTO "categories" ("info_id", "name") VALUES
('f8407af0-8f4d-4191-9130-ad274b28fd08',	'Computer Acessories'),
('f8407af0-8f4d-4191-9130-ad274b28fd08',	'PC Components'),
('44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a',	'Computer Accessories'),
('44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a',	'PC Components'),
('44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a',	'Desktop'),
('f2311244-5de6-4d0a-aa9e-26e07a45cfe8',	'TV & Video'),
('08b67f91-eb81-4fbc-8aaa-4f2b028e9a67',	'DSLR Cameras'),
('7494904b-dd8e-4b4a-8450-d2dddd557a43',	'GPUs'),
('7494904b-dd8e-4b4a-8450-d2dddd557a43',	'Video Graphics Cards'),
('f48eff6f-29fd-4653-9de5-6b8afae376c3',	'Graphics Tablets'),
('9bec438a-1e43-4b28-8ce9-33d62c12b888',	'Hard Drives'),
('9bec438a-1e43-4b28-8ce9-33d62c12b888',	'Components & Storage'),
('9bec438a-1e43-4b28-8ce9-33d62c12b888',	'PC Components');

INSERT INTO "items" ("id", "url", "store_id", "info_id") VALUES
('1c15c1d2-d15d-4724-baf2-8127e465e27b',	'https://www.amazon.com/SanDisk-4TB-Extreme-Portable-SDSSDE61-4T00-G25/dp/B08RX4QKXS/ref=sr_1_3?crid=2WVRKBWQGNY9M&dib=eyJ2IjoiMSJ9.rZA3kYibE8hc7TeWJD6BgavdX9BXgCDN94uGVYGSvoZnc7e_0mGRKMM5Wcl9Mtqv5wNUEunTn2ggshLsNmq7P9UlhStWAUsVRcVZ1gOSbm_7aH7uClp9MeycY3mM8FuoahTqvPzRTFX82Ngh8i5VyteIR8uWCrD7WIlvJFuinUVfWvVC73Jlu4O1BbIejbK0uzrDZ0QGsQL1muv4GfF_hmIrgmN4wfOAmHCGzD65QVA.amUbVZwVRBHCHQD32aE1uoND-lNY0d8fXCgIwmUGluY&dib_tag=se&qid=1709950623&sprefix=ssd,aps,133&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'f8407af0-8f4d-4191-9130-ad274b28fd08'),
('928197ac-32a9-42de-a705-f1e78298d67a',	'https://www.bestbuy.com/site/sandisk-extreme-portable-4tb-external-usb-c-nvme-ssd-black/6472036.p?skuId=6472036',	'1d65acad-e3af-407f-84b0-69658b5c8979',	'f8407af0-8f4d-4191-9130-ad274b28fd08'),
('f0dee6cb-7fff-40f0-8fe0-7b5a3e123fd9',	'https://www.newegg.com/sandisk-extreme-v2-4tb/p/N82E16820173505',	'5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'f8407af0-8f4d-4191-9130-ad274b28fd08'),
('d9581f38-36d0-4669-8f37-cebda0641d28',	'https://www.amazon.com/SAMSUNG-Computing-Workstations-MZ-V9P4T0B-AM/dp/B0CHGT1KFJ/ref=sr_1_8?crid=1TEP5NFQUYTDB&dib=eyJ2IjoiMSJ9.rZA3kYibE8hc7TeWJD6BgavdX9BXgCDN94uGVYGSvoZnc7e_0mGRKMM5Wcl9Mtqv5wNUEunTn2ggshLsNmq7P9UlhStWAUsVRcVZ1gOSbm_7aH7uClp9MeycY3mM8FuoahTqvPzRTFX82Ngh8i5VyteIR8uWCrD7WIlvJFuinUVfWvVC73Jlu4O1BbIejbK0uzrDZ0QGsQL1muv4GfF_hmIrgmN4wfOAmHCGzD65QVA.amUbVZwVRBHCHQD32aE1uoND-lNY0d8fXCgIwmUGluY&dib_tag=se&qid=1709951153&sprefix=ssd,aps,198&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a'),
('0bdbfac8-33af-4844-bd4e-ae123c01101b',	'https://www.bestbuy.com/site/samsung-990-pro-4tb-internal-ssd-pcle-gen-4x4-nvme/6559270.p?skuId=6559270',	'1d65acad-e3af-407f-84b0-69658b5c8979',	'44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a'),
('d5057b59-d065-4db7-8af9-3c06440a3c82',	'https://www.newegg.com/samsung-4tb-990-pro/p/N82E16820147879',	'5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'44fcda87-9b2c-45b0-a96f-1d2ace7b5e6a'),
('1315a066-b8b5-47e1-a787-293252eeea88',	'https://www.amazon.com/LG-55-Inch-Processor-AI-Powered-OLED55C3PUA/dp/B0BVXF72HV/ref=sr_1_2?crid=23ADHW3OV5VXG&dib=eyJ2IjoiMSJ9.CWZwyAedjl5XTrAqckZ6GK_YEPTWqPs7OanZHzN8erWMRkA4_kG9r44NkCyrLOQyRlhOiKpuukO9ZhIl2RR08cgcmCWiCyY5E2022sGI6_ytfnB-0EXcbb04x0FxXXywE0qkGsoFkh3yuJzVj44gb4ILaCeV9Iw0n0HmSXIaXAYBA5V_0sNzdU_aHnqmTyhU49_wwIAF1TXZn1S9MUd7sqQBGAw3JX5TKIfVvkAJ52qOJNcULk7JgbLU6saO1VdAW6DYPNzhpQ6oSpFaQs-hGEVJsbG2C4T8JBZuOC5PexQ.xmTwCya2_9YMnSTulok68i1QhK1XN3uaDC2tHZwbkrc&dib_tag=se&qid=1709951423&s=electronics&sprefix=lg+c3+55,electronics,152&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'f2311244-5de6-4d0a-aa9e-26e07a45cfe8'),
('a4103de3-3db3-4310-95bb-c979f4c229c0',	'https://www.bestbuy.com/site/lg-55-class-c3-series-oled-4k-uhd-smart-webos-tv/6535933.p?skuId=6535933',	'1d65acad-e3af-407f-84b0-69658b5c8979',	'f2311244-5de6-4d0a-aa9e-26e07a45cfe8'),
('7d86ce45-830d-4fd1-a3e2-cf05fa3681a4',	'https://www.walmart.com/ip/LG-55-Class-4K-UHD-OLED-Web-OS-Smart-TV-with-Dolby-Vision-C3-Series-OLED55C3PUA/1935129126?from=/search',	'815a18fe-fbb2-4259-9380-b34c5d97b6c1',	'f2311244-5de6-4d0a-aa9e-26e07a45cfe8'),
('6fe5d91c-7138-4e49-bccd-2fb1ed28aa57',	'https://www.bhphotovideo.com/c/product/1461734-REG/canon_2727c002_eos_rebel_t7_dslr.html',	'034d5e40-347c-414b-a004-25ec4f86b5ab',	'08b67f91-eb81-4fbc-8aaa-4f2b028e9a67'),
('121ae3c8-6135-473f-9cc8-ce6188c0b98d',	'https://www.amazon.com/Canon-Rebel-T7-18-55mm-II/dp/B07C2Z21X5/ref=sr_1_3?crid=2WUK0C4Z80CXF&dib=eyJ2IjoiMSJ9.HHVczMaz0xYLgTghpU7CKUbKbwLrpjRcLm7kiLnnLlZ2n7m0818xeLy7XbQGXrInTcpmsXKdFJMRtJpOMqiDOSQ1vOgx9l2uzWoYg2DUvte7mkbkotVM9sX5fQTO0xL_DChcdQ4ZtXmr6NWHpIKid_6pnEWxqDKvjH5XLdZObzj3OKqcJZBjKzTYmsOUgPVUf1x4biAyoBo9l14BTCovhiRccY7IDF-P3hA_p-kw75RKdwqiA-VbFU7f1ikCUDzdvsWcxNJ8hnObZuqpjRwgG9ppqJCtm9eSPWbpE0_cVVs.sRTjWvN9cU96VDZ07S2LWQa9dDZNGxxSJQM8LFpg2bI&dib_tag=se&qid=1709951699&s=electronics&sprefix=cannon+camera,electronics,160&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'08b67f91-eb81-4fbc-8aaa-4f2b028e9a67'),
('8458449b-e193-4a0e-9bb8-b5ecdf4b7baf',	'https://www.newegg.com/canon-2727c002/p/111-0009-00571',	'5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'08b67f91-eb81-4fbc-8aaa-4f2b028e9a67'),
('1eecaf59-ae8e-4b43-83ba-a25e438940cd',	'https://www.bestbuy.com/site/nvidia-geforce-rtx-4070-super-12gb-gddr6x-graphics-card-titanium-black/6570226.p?skuId=6570226',	'1d65acad-e3af-407f-84b0-69658b5c8979',	'7494904b-dd8e-4b4a-8450-d2dddd557a43'),
('ea1720c2-8194-44a0-8621-5722e91370f0',	'https://www.amazon.com/Wacom-Drawing-Software-Included-CTL4100/dp/B079HL9YSF/ref=sr_1_3?crid=27STNDKUV22FY&dib=eyJ2IjoiMSJ9.Sr6cjadi1L2gr_8jNYP9G5erVEru1RPrNzNkkbaolZqH3x8f6XzieRcqUrh9ApN-ZICfx5glsjZySJ-eKCvjEGPao9WtKKDqt16C6rc4J81-maJu6Awt49sFxctwP0pLN8tfN8d-nx6Sgq0Vi4o_7vTP82_A7f5GhHxsUE6LBMuNvA6mPmrCFhIh5g4jfiYHfjfhQJyfp52v4yxUmVi_ihiJHNa9D7FeQo3v3k8ijHc.EiOR-BG68yPe00qF5NIz4I51uq2BVqqOulvRf8B2d_M&dib_tag=se&qid=1709952706&sprefix=wacom+intuos,aps,146&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'f48eff6f-29fd-4653-9de5-6b8afae376c3'),
('1dfbd33d-324f-41f2-87a0-831ffdbfb00e',	'https://www.newegg.com/black-wacom-ctl4100/p/N82E16823100232',	'5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'f48eff6f-29fd-4653-9de5-6b8afae376c3'),
('0f8713be-5d9f-4b06-ba86-fc8dca4485c4',	'https://www.newegg.com/black-wd101fzbx-10tb/p/N82E16822234427',	'5c9fd94e-b4b0-41b5-8bb8-c6dbcbec1a24',	'9bec438a-1e43-4b28-8ce9-33d62c12b888'),
('3ad531a9-16e8-4ab8-aaa9-dc3befd3b9a8',	'https://www.amazon.com/Western-Digital-Black-Performance-Internal/dp/B08MKJPFZ7?ref_=ast_sto_dp&th=1',	'ecb0edd7-a61f-4e52-840b-72b746550120',	'9bec438a-1e43-4b28-8ce9-33d62c12b888');

INSERT INTO "price_data" ("item_id", "xpath", "price", "price_diff", "last_update", "next_update", "min_price", "min_price_ts", "max_price", "max_price_ts", "update_freq", "status") VALUES
('1c15c1d2-d15d-4724-baf2-8127e465e27b',	'/html/body/div[1]/div/div[9]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div/div[1]/div/div/div[1]/div/div[1]/h5/div[2]/div/div[1]/div/div/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('928197ac-32a9-42de-a705-f1e78298d67a',	'/html/body/div[4]/main/div[5]/div/div/div/div/div/div/div[7]/div[2]/div/div[3]/div/div/div/div/div/div/div[1]/div[1]/div[1]/div',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('f0dee6cb-7fff-40f0-8fe0-7b5a3e123fd9',	'/html/body/div[32]/div[3]/div/div/div/div[1]/div[1]/div[1]/div/ul/li[3]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('d9581f38-36d0-4669-8f37-cebda0641d28',	'/html/body/div[1]/div/div[9]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div/div[1]/div/div/div[1]/div/div[1]/h5/div[2]/div/div[1]/div/div/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('0bdbfac8-33af-4844-bd4e-ae123c01101b',	'/html/body/div[4]/main/div[5]/div/div/div/div/div/div/div[7]/div[2]/div/div[3]/div/div/div/div/div/div/div[1]/div[1]/div[1]/div',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('d5057b59-d065-4db7-8af9-3c06440a3c82',	'/html/body/div[32]/div[3]/div/div[2]/div/div[1]/div[1]/div[1]/div/ul/li[3]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1 day',	'NEW'),
('1315a066-b8b5-47e1-a787-293252eeea88',	'/html/body/div[4]/div/div[11]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div[1]/div/div[1]/h5/div[2]/div/div[1]/div/div/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2 days',	'NEW'),
('a4103de3-3db3-4310-95bb-c979f4c229c0',	'/html/body/div[4]/main/div[5]/div/div/div/div/div/div/div[4]/div[2]/div[2]/div[4]/div/div/div/div/div/div/div[1]/div[1]/div[1]/div',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2 days',	'NEW'),
('7d86ce45-830d-4fd1-a3e2-cf05fa3681a4',	'/html/body/div/div[1]/div/div/div[2]/div/section/main/div[2]/div[2]/div/div[1]/div/div[2]/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2 days',	'NEW'),
('6fe5d91c-7138-4e49-bccd-2fb1ed28aa57',	'/html/body/div[1]/main/section/div/div[2]/div[6]/div/div[2]/div/div/div[2]/div/div',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'3 days 05:30:00',	'NEW'),
('121ae3c8-6135-473f-9cc8-ce6188c0b98d',	'/html/body/div[1]/div/div[9]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div/div[1]/div/div/div[1]/div/div[1]/h5/div[2]/div/div[1]/div/div/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'3 days 05:30:00',	'NEW'),
('8458449b-e193-4a0e-9bb8-b5ecdf4b7baf',	'/html/body/div[32]/div[3]/div/div/div/div[1]/div[1]/div[1]/div/ul/li[3]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'3 days 05:30:00',	'NEW'),
('1eecaf59-ae8e-4b43-83ba-a25e438940cd',	'/html/body/div[4]/main/div[5]/div/div/div/div/div/div/div[7]/div[2]/div/div[3]/div/div/div/div/div/div/div[1]/div[1]/div/div',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'3 days 08:30:00',	'NEW'),
('ea1720c2-8194-44a0-8621-5722e91370f0',	'/html/body/div[1]/div/div[9]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div/div[1]/div/div/div[1]/div/div[1]/h5/div[2]/div/div[1]/div/div/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'7 days',	'NEW'),
('1dfbd33d-324f-41f2-87a0-831ffdbfb00e',	'/html/body/div[32]/div[3]/div/div[2]/div/div[1]/div[1]/div[1]/div/ul/li[3]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'7 days',	'NEW'),
('0f8713be-5d9f-4b06-ba86-fc8dca4485c4',	'/html/body/div[32]/div[3]/div/div/div/div[1]/div[1]/div[1]/div/ul/li[3]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'4 days 12:30:00',	'NEW'),
('3ad531a9-16e8-4ab8-aaa9-dc3befd3b9a8',	'/html/body/div[1]/div/div[9]/div[5]/div[1]/div[6]/div/div[1]/div/div[1]/div/div/div/div/div/form/div/div/div/div/div[3]/div/div[1]/div/div/span[1]',	0,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'4 days 12:30:00',	'NEW');
