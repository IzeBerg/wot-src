package net.wg.gui.bootcamp
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.ribbonsPanel.AnimationSet;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonCtrl;
   import net.wg.infrastructure.base.meta.IBCSecondaryHintMeta;
   import net.wg.infrastructure.base.meta.impl.BCSecondaryHintMeta;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.utils.IClassFactory;
   
   public class BCSecondaryHint extends BCSecondaryHintMeta implements IBCSecondaryHintMeta
   {
      
      private static const HIDE_ANIM:String = "hide";
      
      private static const HINT_BACKGROUND_X:int = 0;
      
      private static const HINT_TYPE_ICON_Y:int = -5;
      
      private static const HINT_TYPE_TEXT_Y:int = 8;
      
      private static const HINT_TYPE_TEXT_X:int = 46;
      
      private static const CENTER_OFFSET:int = -30;
      
      private static const SINGLE_LINE_HEIGHT:int = 22;
       
      
      public var iconsAnim:AnimationSet = null;
      
      public var textsAnim:AnimationSet = null;
      
      public var hintText:MovieClip;
      
      public var hintIcon:MovieClip;
      
      private var _hintTypeIcon:Shape = null;
      
      private var _background:Shape = null;
      
      private var _atlasMgr:IAtlasManager = null;
      
      private var _textField:TextField = null;
      
      public function BCSecondaryHint()
      {
         super();
         var _loc1_:IClassFactory = App.utils.classFactory;
         var _loc2_:Class = _loc1_.getClass(Linkages.SECONDARY_HINT_ANIMATION_SET);
         this.iconsAnim = new _loc2_();
         this.textsAnim = new _loc2_();
         this.hintIcon = new MovieClip();
         this.textsAnim.init(this.hintText);
         this.iconsAnim.init(this.hintIcon);
         this._textField = this.hintText.textField;
         this.iconsAnim.visible = false;
         this.iconsAnim.stop();
         this.textsAnim.visible = false;
         this.textsAnim.stop();
         this._background = new Shape();
         this._hintTypeIcon = new Shape();
         this._hintTypeIcon.y = HINT_TYPE_ICON_Y;
         this.hintText.x = HINT_TYPE_TEXT_X;
         this.hintText.y = HINT_TYPE_TEXT_Y;
         this._background.x = HINT_BACKGROUND_X;
         this.hintIcon.addChild(this._background);
         this.hintIcon.addChild(this._hintTypeIcon);
         this._atlasMgr = App.atlasMgr;
         this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,"ribbonsBgOrangeLarge",this._background.graphics);
         this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,"ribbonsExclamation",this._hintTypeIcon.graphics);
         addChild(this.iconsAnim);
         addChild(this.textsAnim);
         this.hintText.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this._background = null;
         this._hintTypeIcon = null;
         this._atlasMgr = null;
         this._textField = null;
         this.iconsAnim.dispose();
         this.iconsAnim = null;
         this.textsAnim.dispose();
         this.textsAnim = null;
      }
      
      public function as_hideHint() : void
      {
         this.onLifetimeCooldown();
      }
      
      public function as_showHint(param1:String) : void
      {
         this.textsAnim.visible = true;
         this.iconsAnim.visible = true;
         this.iconsAnim.gotoAndPlay(RibbonCtrl.SHOW_ANIM);
         this.iconsAnim.glowAnim.gotoAndPlay(1);
         this.textsAnim.gotoAndPlay(RibbonCtrl.SHOW_ANIM);
         this._textField.text = param1.toUpperCase();
         var _loc2_:int = SINGLE_LINE_HEIGHT - this._textField.textHeight;
         this.iconsAnim.y = _loc2_;
         this.textsAnim.y = _loc2_;
         this.iconsAnim.x = this.textsAnim.x = CENTER_OFFSET - (this._textField.textWidth >> 1);
      }
      
      private function onLifetimeCooldown() : void
      {
         this.iconsAnim.gotoAndPlay(HIDE_ANIM);
         this.textsAnim.gotoAndPlay(HIDE_ANIM);
      }
   }
}
