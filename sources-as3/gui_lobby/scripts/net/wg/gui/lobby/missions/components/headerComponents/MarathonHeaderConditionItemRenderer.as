package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.missions.data.TokenRendererVO;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.core.UIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class MarathonHeaderConditionItemRenderer extends ListItemRenderer implements IPopOverCaller
   {
      
      private static const TITLE_GAP:int = 6;
      
      private static const IMG_BIG_BOUNDS_WIDTH:int = 80;
      
      private static const IMG_NORMAL_BOUNDS_WIDTH:int = 60;
      
      private static const IMG_BOUNDS_HEIGHT:int = 80;
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const BIG_STATE:String = "big";
      
      private static const SEPARATOR_Y_SHIFT:int = -4;
      
      private static const STATES_Y_SHIFT:int = 20;
       
      
      public var img:Image = null;
      
      public var countTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      public var separator:Sprite = null;
      
      public var states:MovieClip = null;
      
      private var _model:TokenRendererVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _popoverMgr:IPopoverManager;
      
      private var _isNormalSize:Boolean = true;
      
      public function MarathonHeaderConditionItemRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._popoverMgr = App.popoverMgr;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this._isNormalSize = this._model.isNormalSize;
            buttonMode = this._model.popoverEnable;
            if(this._isNormalSize)
            {
               gotoAndStop(NORMAL_STATE);
            }
            else
            {
               gotoAndStop(BIG_STATE);
            }
            if(this._model.titleText)
            {
               this.titleTF.htmlText = this._model.titleText;
            }
            this.img.source = this._model.imgSrc;
            this.img.sourceAlt = this._model.imgSrcAlt;
            this.countTF.htmlText = this._model.countText;
            scaleX = scaleY = 1;
            App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
            invalidateSize();
         }
         if(this._model && isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
            visible = true;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         visible = false;
         this.titleTF.visible = false;
         _labelHash = UIComponent.generateLabelHash(this.states);
      }
      
      override protected function setState(param1:String) : void
      {
         super.setState(param1);
         if(_labelHash[param1])
         {
            this.states.gotoAndPlay(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this.img.dispose();
         this.img = null;
         this.countTF = null;
         this.separator = null;
         this.states = null;
         this.titleTF = null;
         this._model = null;
         this._tooltipMgr = null;
         this._popoverMgr = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         if(this._model.popoverEnable)
         {
            this._popoverMgr.show(this,QUESTS_ALIASES.MISSIONS_TOKEN_POPOVER_ALIAS,this._model);
            this._tooltipMgr.hide();
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         this.updateLayout();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.img;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.img;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(null != this._model)
         {
            _loc2_ = !!this._isNormalSize ? int(IMG_NORMAL_BOUNDS_WIDTH) : int(IMG_BIG_BOUNDS_WIDTH);
            if(StringUtils.isNotEmpty(this._model.titleText))
            {
               _loc1_ = _loc2_ + TITLE_GAP + this.titleTF.textWidth;
               TextFieldEx.setVerticalAlign(this.titleTF,TextFieldEx.VALIGN_CENTER);
               this.states.x = _loc1_ - this.states.width >> 1;
               this.separator.x = _loc1_ - this.separator.width >> 1;
               this.countTF.x = _loc1_ - this.countTF.width >> 1;
               this.img.x = 0;
               this.titleTF.x = this.img.x + _loc2_ + TITLE_GAP;
               this.titleTF.visible = true;
            }
            else
            {
               this.states.x = 0;
               _loc1_ = this.states.width;
               this.separator.x = _loc1_ - this.separator.width >> 1;
               this.countTF.x = _loc1_ - this.countTF.width >> 1;
               this.img.x = _loc1_ - _loc2_ >> 1;
            }
            this.separator.y = this.countTF.y - this.separator.height + SEPARATOR_Y_SHIFT;
            this.states.y = this.separator.y + STATES_Y_SHIFT;
            this.img.y = IMG_BOUNDS_HEIGHT - (!!this._isNormalSize ? IMG_NORMAL_BOUNDS_WIDTH : IMG_BIG_BOUNDS_WIDTH) >> 1;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         this._model = TokenRendererVO(param1);
         this._tooltipMgr.hide();
         invalidateData();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.MISSIONS_TOKEN,null,this._model.tokenId,this._model.questId);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._tooltipMgr.hide();
      }
   }
}
