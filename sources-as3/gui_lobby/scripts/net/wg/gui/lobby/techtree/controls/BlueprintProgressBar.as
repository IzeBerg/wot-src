package net.wg.gui.lobby.techtree.controls
{
   public class BlueprintProgressBar extends FadeComponent
   {
      
      private static const COMPLETED_FRAME_LABEL:String = "completed";
       
      
      private var _completed:Boolean = false;
      
      public function BlueprintProgressBar()
      {
         super();
      }
      
      override protected function updateEnabledState(param1:Boolean) : void
      {
         if(this._completed)
         {
            gotoAndPlay(COMPLETED_FRAME_LABEL);
         }
         else
         {
            super.updateEnabledState(param1);
         }
      }
      
      public function get completed() : Boolean
      {
         return this._completed;
      }
      
      public function set completed(param1:Boolean) : void
      {
         if(this._completed == param1)
         {
            return;
         }
         this._completed = param1;
         invalidateState();
      }
   }
}
