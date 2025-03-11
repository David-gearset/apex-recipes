public class CaseCreatorScheduler {
    public void Schedule() {
        // Can't run jobs more than every hour but we can queue up 4 and ofset them by 15 minutes
        System.schedule('GenerateCascade0min', '0 0 * * * ?', new CaseCreator());
        System.schedule('GenerateCascade15min', '0 15 * * * ?', new CaseCreator());
        System.schedule('GenerateCascade30min', '0 30 * * * ?', new CaseCreator());
        System.schedule('GenerateCascade45min', '0 45 * * * ?', new CaseCreator());
    }
}