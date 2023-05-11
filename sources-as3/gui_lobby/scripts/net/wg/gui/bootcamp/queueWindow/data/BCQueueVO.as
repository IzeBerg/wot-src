package net.wg.gui.bootcamp.queueWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   
   public class BCQueueVO extends DAAPIDataClass
   {
      
      private static const LESSON_PAGE_BIG_DATA:String = "lessonPageBigData";
      
      private static const LESSON_PAGE_SMALL_DATA:String = "lessonPageSmallData";
       
      
      public var showTutorialPages:Boolean = false;
      
      public var backgroundImage:String = "";
      
      public var lessonPageBigData:BCTutorialPageVO = null;
      
      public var lessonPageSmallData:BCTutorialPageVO = null;
      
      public function BCQueueVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == LESSON_PAGE_BIG_DATA)
         {
            this.lessonPageBigData = new BCTutorialPageVO(param2);
            return false;
         }
         if(param1 == LESSON_PAGE_SMALL_DATA)
         {
            this.lessonPageSmallData = new BCTutorialPageVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.lessonPageBigData)
         {
            this.lessonPageBigData.dispose();
            this.lessonPageBigData = null;
         }
         if(this.lessonPageSmallData)
         {
            this.lessonPageSmallData.dispose();
            this.lessonPageSmallData = null;
         }
         super.onDispose();
      }
   }
}
