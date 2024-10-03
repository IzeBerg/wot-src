package net.wg.white_tiger.gui.battle.views.shared
{
   import net.wg.gui.battle.components.BaseProgressCircle;
   
   public class GeneratorProgressCircle extends BaseProgressCircle
   {
      
      private static const FRAME_LABEL_ONLINE:String = "online";
      
      private static const FRAME_LABEL_CAPTURING:String = "capture";
      
      private static const FRAME_LABEL_OFFLINE:String = "offline";
      
      private static const LAST_FRAME:int = 146;
       
      
      public function GeneratorProgressCircle()
      {
         super();
      }
      
      override public function updateProgress(param1:Number) : void
      {
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
         gotoAndStop(FRAME_LABEL_ONLINE);
      }
      
      protected function get defaultEmptyFrame() : int
      {
         return LAST_FRAME;
      }
   }
}
