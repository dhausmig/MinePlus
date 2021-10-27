
minetest.register_craft({
	output = 'technic:hv_cable 3',
	recipe = {
		{'default:plastic_sheet', 'default:plastic_sheet', 'default:plastic_sheet'},
		{'technic:mv_cable',           'technic:mv_cable',           'technic:mv_cable'},
		{'default:plastic_sheet', 'default:plastic_sheet', 'default:plastic_sheet'},
	}
}) 

technic.register_cable("HV", 3/16)

