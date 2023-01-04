# wrong row when UITableView did select delegate called when dismiss keyboard by tap gesture

tap gesture for dismiss keyboard in tableView will row at didSelect delegate

## pre conditions:
didSelectAtRow Delegate will toggle to check status.

tapGesture will dismiss keyboard.(cancelsTouchesInView is false. this able to didSelect event with tap gesture)

safe area will changed when keyboard be showing or hiding.(for scrolling to end when keyboard show up)


## produce steps

step1: tap a textfield at bottom cell

step2: tap a avoid in cell


## result

keyboard hide and wrong cell selected


<image src="https://user-images.githubusercontent.com/3124813/210523037-5ad90591-b05e-4a2e-ac16-b2b2d1fc45cb.gif" width=300>
