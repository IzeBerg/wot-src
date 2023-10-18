package net.wg.gui.lobby.eventBoards.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class LevelTypeFlagRendererText extends LevelTypeFlagRenderer
   {
       
      
      public var descriptionTF:TextField;
      
      public function LevelTypeFlagRendererText()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         _rendererData = SimpleRendererVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(_rendererData != null && _rendererData.tooltip)
            {
               this.descriptionTF.text = _rendererData.tooltip;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.descriptionTF = null;
         super.onDispose();
      }
   }
}
