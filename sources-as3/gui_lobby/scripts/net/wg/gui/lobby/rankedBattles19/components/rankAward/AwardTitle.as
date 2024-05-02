package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardTitle extends UIComponentEx
   {
      
      private static const INV_MAXIMIZED:String = "maximized";
      
      private static const TITLE_FONT_SIZE_SMALL:int = 56;
      
      private static const TITLE_FONT_SIZE_BIG:int = 110;
      
      private static const TITLE_Y_SMALL:int = 55;
      
      private static const TITLE_Y_BIG:int = 0;
       
      
      public var textsMc:MovieClip = null;
      
      private var _titleTF:TextField = null;
      
      private var _descrTF:TextField = null;
      
      private var _titleText:String = null;
      
      private var _descrText:String = null;
      
      private var _isMaximized:Boolean = true;
      
      public function AwardTitle()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._titleTF = this.textsMc.titleTF;
         this._descrTF = this.textsMc.descrTF;
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(StringUtils.isNotEmpty(this._titleText))
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._titleTF.htmlText = this._titleText;
               this._descrTF.htmlText = this._descrText;
            }
            if(isInvalid(INV_MAXIMIZED))
            {
               _loc1_ = this._titleTF.getTextFormat();
               _loc1_.size = !!this._isMaximized ? TITLE_FONT_SIZE_BIG : TITLE_FONT_SIZE_SMALL;
               this._titleTF.setTextFormat(_loc1_);
               this._titleTF.y = !!this._isMaximized ? Number(TITLE_Y_BIG) : Number(TITLE_Y_SMALL);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.textsMc = null;
         this._titleTF = null;
         this._descrTF = null;
         super.onDispose();
      }
      
      public function setTexts(param1:String, param2:String) : void
      {
         this._titleText = param1;
         this._descrText = param2;
         invalidateData();
      }
      
      public function set isMaximized(param1:Boolean) : void
      {
         if(this._isMaximized != param1)
         {
            this._isMaximized = param1;
            invalidate(INV_MAXIMIZED);
         }
      }
   }
}
