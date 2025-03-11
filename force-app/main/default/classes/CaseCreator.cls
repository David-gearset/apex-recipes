global class CaseCreator implements Schedulable {

    Integer CaseCount = 0;
    
    RandomDataGenerator randomizer = new RandomDataGenerator();
    
    private void Initialise() {
        CaseCount = [SELECT COUNT() FROM Case];
    }
    
    //
    // Cases
    // 
    private void CreateRandomCase() {
        Case newCase = new Case();
        
        // Generate a random priority
        Integer priorityIndex = randomizer.GetRandomNumber(3); // Random number between 0 and 2
        switch on priorityIndex {
            when 0 {
                newCase.Priority = 'Low';
            }
            when 1 {
                newCase.Priority = 'Medium';
            }
            when 2 {
                newCase.Priority = 'High';
            }
        }
        
        // Generate a random origin
        Integer originIndex = randomizer.GetRandomNumber(3); // Random number between 0 and 2
        switch on originIndex {
            when 0 {
                newCase.Origin = 'Phone';
            }
            when 1 {
                newCase.Origin = 'Email';
            }
            when 2 {
                newCase.Origin = 'Web';
            }
        }
        
        // Generate a random subject
        List<String> subjects = new List<String>{
            'Technical Support Issue',
            'Billing Inquiry',
            'Account Access Problem',
            'Feature Request',
            'Bug Report',
            'General Inquiry'
        };
        Integer subjectIndex = randomizer.GetRandomNumber(subjects.size());
        newCase.Subject = subjects[subjectIndex];
        
        newCase.IsEscalated = randomizer.GenerateRandomBool();
        newCase.Reason = randomizer.GenerateRandomStringOfMaxLength(10);
        
        insert newCase;
        CaseCount = CaseCount + 1;
    }
    
    global void execute(SchedulableContext ctx) {
        
        Initialise();
        
        Integer targetCaseCount = 100;
        Integer casesToCreate = targetCaseCount - CaseCount;
        
        for (Integer i = 0; i < casesToCreate; i++) {
            CreateRandomCase();
        }
        
        String now = Datetime.now().format();
        System.debug('Data munger ran @ ' + now + ' and created ' + casesToCreate + ' cases.');
    }   
}