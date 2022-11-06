package net.wg.gui.components.carousels.controls.levelInfo
{
   import flash.display.MovieClip;
   import scaleform.clik.controls.Button;
   
   public class LevelInfoButton extends Button
   {
       
      
      public var iconNormal:MovieClip = null;
      
      public var iconOver:MovieClip = null;
      
      public var hitMc:MovieClip = null;
      
      public var bgMc:MovieClip = null;
      
      public function LevelInfoButton()
      {
         super();
         useHandCursor = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.hitMc != null)
         {
            this.hitArea = this.hitMc;
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconNormal = null;
         this.iconOver = null;
         this.hitMc = null;
         this.bgMc = null;
         super.onDispose();
      }
      
      public function updateState(param1:String) : void
      {
         this.hitMc.gotoAndStop(param1);
         this.iconNormal.gotoAndStop(param1);
         this.iconOver.gotoAndStop(param1);
         this.bgMc.gotoAndStop(param1);
      }
   }
}
