package net.wg.gui.battle.battleRoyale.views.components
{
   import net.wg.infrastructure.base.meta.ICorrodingShotIndicatorMeta;
   import net.wg.infrastructure.base.meta.impl.CorrodingShotIndicatorMeta;
   
   public class CorrodingShotIndicator extends CorrodingShotIndicatorMeta implements ICorrodingShotIndicatorMeta
   {
      
      private static const SHOW_STATE_FRAME_LABEL:String = "show";
      
      private static const HIDE_STATE_FRAME_LABEL:String = "hide";
       
      
      public function CorrodingShotIndicator()
      {
         super();
      }
      
      public function as_show() : void
      {
         this.gotoAndStop(SHOW_STATE_FRAME_LABEL);
      }
      
      public function as_hide() : void
      {
         this.gotoAndStop(HIDE_STATE_FRAME_LABEL);
      }
      
      public function as_updateLayout(param1:Number, param2:Number) : void
      {
         this.x = param1 | 0;
         this.y = param2 | 0;
      }
   }
}
