package net.wg.gui.battle.components
{
   public class EventGeneratorProgressCircle extends BaseProgressCircle
   {
      
      private static const FRAME_LABEL_ONLINE:String = "online";
      
      private static const FRAME_LABEL_CAPTURING:String = "capture";
      
      private static const FRAME_LABEL_OFFLINE:String = "offline";
      
      private static const FRAME_LABEL_LOCKED:String = "locked";
      
      private static const LAST_FRAME:int = 146;
       
      
      private var isGeneratorLocked:Boolean = false;
      
      public function EventGeneratorProgressCircle()
      {
         super();
         this.resetGenerator();
      }
      
      override public function updateProgress(param1:Number) : void
      {
         if(this.isGeneratorLocked)
         {
            return;
         }
         if(currentFrameLabel != FRAME_LABEL_CAPTURING)
         {
            gotoAndStop(FRAME_LABEL_CAPTURING);
         }
         var _loc2_:int = param1 / 100 * LAST_FRAME | 0;
         progressCircle.gotoAndStop(_loc2_);
      }
      
      override protected function getCorrectState(param1:String) : String
      {
         return FRAME_LABEL_CAPTURING;
      }
      
      public function resetGenerator() : void
      {
         if(this.isGeneratorLocked)
         {
            return;
         }
         gotoAndStop(FRAME_LABEL_ONLINE);
      }
      
      public function setGeneratorOffline() : void
      {
         gotoAndStop(FRAME_LABEL_OFFLINE);
      }
      
      public function setGeneratorLocked(param1:Boolean) : void
      {
         this.isGeneratorLocked = param1;
         if(this.isGeneratorLocked)
         {
            gotoAndStop(FRAME_LABEL_LOCKED);
         }
         else
         {
            gotoAndStop(FRAME_LABEL_ONLINE);
         }
      }
   }
}
