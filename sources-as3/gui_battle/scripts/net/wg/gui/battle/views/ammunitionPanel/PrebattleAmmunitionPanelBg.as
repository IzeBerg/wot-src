package net.wg.gui.battle.views.ammunitionPanel
{
   import flash.display.Sprite;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class PrebattleAmmunitionPanelBg extends UIComponent
   {
       
      
      public var splitter:Sprite;
      
      public var bgNoise:Sprite;
      
      public var bgShape:Sprite;
      
      public function PrebattleAmmunitionPanelBg()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.splitter.width = width;
            this.bgNoise.width = width;
            this.bgShape.width = width;
         }
      }
      
      override protected function onDispose() : void
      {
         this.splitter = null;
         this.bgNoise = null;
         this.bgShape = null;
         super.onDispose();
      }
   }
}
