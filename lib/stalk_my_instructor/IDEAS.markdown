we have an array, in which each iteration is equal to an experience box 

this_array["experience1", "experience2", "experience3"]

Our hash table will look something like this 

Master_hash =>
  Experience = [
    experience1 => [],
    experience2 => [],
    experience3 => [],
    ]

With the data we have, let's say we have an h5 that we don't know which experience key it belongs to. So we will do: 

      counter = 1
      array.each do |experience|
        if experince.include?(h5)
            then I know to put the h5 into the experience[array_index] key in the hash

            name_of_key = experience2.key
            master_hash[name_of_key]



        i = 0
        this_array.each do |experience|
          if experince.include?(h5)
            Master_hash[:Experience][i][job_title] => h5
          else
            i += 1
          end 
        end

        def find_keys(missing, key)
          i = 0
            this_array.each do |experience|
          if experince.include?(missing)
            Master_hash[:Experience][i][key] => h5
          else
            i += 1
          end 
        end

Master_hash =>
  Experience = [
    experience1 => {job title: __, company, description},
    experience2 => [],
    experience3 => [],
    ]