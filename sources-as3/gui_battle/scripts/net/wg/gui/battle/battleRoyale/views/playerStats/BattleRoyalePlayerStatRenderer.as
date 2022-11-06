package net.wg.gui.battle.battleRoyale.views.playerStats
{
   import fl.motion.easing.Cubic;
   import flash.display.BlendMode;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleDisplayable;
   import scaleform.clik.motion.Tween;
   
   public class BattleRoyalePlayerStatRenderer extends BattleDisplayable
   {
      
      private static const FADE_IN_DURATION:Number = 500;
      
      private static const FADE_IN_Y:Number = 0;
      
      private static const FADE_IN_Y_OFFSET:Number = 50;
      
      private static const FADE_IN_ALPHA:Number = 1;
       
      
      public var statCountTF:TextField = null;
      
      public var statNameTF:TextField = null;
      
      public var icon:BattleAtlasSprite = null;
      
      public var iconBg:BattleAtlasSprite = null;
      
      private var _currentTween:Tween = null;
      
      public function BattleRoyalePlayerStatRenderer()
      {
         super();
         blendMode = BlendMode.SCREEN;
      }
      
      public function fadeIn(param1:Number = 0) : void
      {
         this.clearTween();
         alpha = 0;
         y = FADE_IN_Y_OFFSET;
         this._currentTween = new Tween(FADE_IN_DURATION,this,{
            "alpha":FADE_IN_ALPHA,
            "y":FADE_IN_Y
         },{
            "delay":param1,
            "ease":Cubic.easeOut
         });
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statCountTF.autoSize = TextFieldAutoSize.CENTER;
         this.statNameTF.autoSize = TextFieldAutoSize.CENTER;
         this.iconBg.imageName = BATTLEATLAS.WREATH_SILVER;
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         this.statNameTF.text = param1;
         this.icon.imageName = param2;
         this.statCountTF.htmlText = Boolean(param3) ? param3 : Values.EMPTY_STR;
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.statCountTF = null;
         this.statNameTF = null;
         this.icon = null;
         this.iconBg = null;
         super.onDispose();
      }
      
      private function clearTween() : void
      {
         if(this._currentTween)
         {
            this._currentTween.paused = true;
            this._currentTween.dispose();
            this._currentTween = null;
         }
      }
   }
}
