local module = {}

function module.getMatchingKeyCodeFromValue(Value: number)
	for i, Keycode in Enum.KeyCode:GetEnumItems() do
		if Keycode.Value == Value then
			return Keycode
		end
	end
end

return module