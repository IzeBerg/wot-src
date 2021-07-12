package net.wg.gui.components.paginator
{
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.StateManagerEvent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.utils.Constraints;
   
   public class PaginatorArrowBtn extends SoundButtonEx
   {
      
      private static const FRAME_LABEL_NORMAL:String = "normal";
      
      private static const FRAME_LABEL_DISABLE:String = "disable";
       
      
      public var arrow:FrameStateCmpnt = null;
      
      public function PaginatorArrowBtn()
      {
         super();
         soundType = SoundTypes.PAGINATOR_ARROW_BTN;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!constraintsDisabled)
         {
            constraints.addElement(this.arrow.name,this.arrow,Constraints.CENTER_V);
         }
      }
      
      override protected function updateDisable() : void
      {
         super.updateDisable();
         this.arrow.frameLabel = !!enabled ? FRAME_LABEL_NORMAL : FRAME_LABEL_DISABLE;
      }
      
      override protected function updateAfterStateChange() : void
      {
         if(!initialized)
         {
            return;
         }
         if(constraints != null && !constraintsDisabled)
         {
            constraints.updateElement(this.arrow.name,this.arrow);
         }
         dispatchEvent(new StateManagerEvent(ComponentEvent.STATE_CHANGE,state));
      }
      
      override protected function onDispose() : void
      {
         this.arrow.dispose();
         this.arrow = null;
         super.onDispose();
      }
   }
}
