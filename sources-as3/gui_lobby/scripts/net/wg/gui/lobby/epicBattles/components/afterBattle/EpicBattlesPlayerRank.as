package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EpicBattlesPlayerRank extends UIComponentEx
   {
      
      private static const TITLE_Y:int = 218;
      
      private static const INTRO_ANIMATION_STATE:String = "rankIntro";
       
      
      public var rank:MovieClip = null;
      
      public var rankDescrText:MovieClip = null;
      
      public var rankTitleText:MovieClip = null;
      
      private var _titleTF:TextField = null;
      
      private var _descTF:TextField = null;
      
      public function EpicBattlesPlayerRank()
      {
         super();
         mouseChildren = mouseEnabled = false;
         this._titleTF = this.rankTitleText.rankTitleTF;
         this._descTF = this.rankDescrText.rankDescTF;
         this._descTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onBeforeDispose() : void
      {
         stop();
         this.rank.stop();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._titleTF = null;
         this._descTF = null;
         this.rank = null;
         this.rankDescrText = null;
         this.rankTitleText = null;
         super.onDispose();
      }
      
      public function playIntro() : void
      {
         gotoAndPlay(INTRO_ANIMATION_STATE);
      }
      
      public function setDescText(param1:String) : void
      {
         this._descTF.htmlText = param1;
      }
      
      public function setRank(param1:int) : void
      {
         this.rank.gotoAndStop(param1);
      }
      
      public function setTitleText(param1:String) : void
      {
         this._titleTF.htmlText = param1;
         this.updateSizeAndPlacement(this._titleTF);
      }
      
      private function updateSizeAndPlacement(param1:TextField) : void
      {
         App.utils.commons.updateTextFieldSize(param1,true,true);
         param1.x = -param1.width >> 1;
      }
      
      override public function get height() : Number
      {
         return TITLE_Y + this.rankTitleText.height;
      }
   }
}
