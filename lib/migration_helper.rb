module MigrationHelper
	def foreign_key(from_table, from_column, to_table, to_column = 'id')
		constraint = "fk_#{from_table}_#{from_column}"
		execute "ALTER TABLE #{from_table}
		ADD CONSTRAINT #{constraint}
		FOREIGN KEY (#{from_column}) REFERENCES #{to_table}(#{to_column})"
	end
end
