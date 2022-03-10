package net.wg.data.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.events.TutorialEvent;
   
   public class TutorialCriteriaVo extends DAAPIDataClass
   {
       
      
      public var viewTutorialId:String = "";
      
      public var criteriaValue:String = "";
      
      public var parentViewAlias:String = "";
      
      public var tutorialEvent:TutorialEvent = null;
      
      public var vo:TutorialComponentPathVO = null;
      
      public function TutorialCriteriaVo(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[TutorialComponentPathVO " + this.criteriaValue + ", " + this.parentViewAlias + ", " + this.tutorialEvent + ", " + this.vo + ", " + this.viewTutorialId + " ]";
      }
      
      override protected function onDispose() : void
      {
         if(this.tutorialEvent)
         {
            this.clearTutorialEvent(this.tutorialEvent);
            this.tutorialEvent = null;
         }
         this.vo = null;
         super.onDispose();
      }
      
      private function clearTutorialEvent(param1:TutorialEvent) : void
      {
         if(param1.pathPointNames)
         {
            param1.pathPointNames.splice(0,param1.pathPointNames.length);
            param1.pathPointNames = null;
         }
         if(param1.pathPointObjects)
         {
            param1.pathPointObjects.splice(0,param1.pathPointObjects.length);
            param1.pathPointObjects = null;
         }
      }
   }
}
