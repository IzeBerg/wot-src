package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowAbstractItemVO;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanInvitesWindowAbstractTableItemRenderer extends TableRenderer
   {
      
      private static const TOOLTIP_MAX_WIDTH:int = 255;
       
      
      public var messageIcon:Image = null;
      
      public var personalRatingTF:TextField = null;
      
      public var battlesCountTF:TextField = null;
      
      public var winsTF:TextField = null;
      
      public var awgExpTF:TextField = null;
      
      public var statusTF:TextField = null;
      
      public var messageArea:Sprite = null;
      
      public var showMoreButton:IconTextButton = null;
      
      private var _commons:ICommons = null;
      
      private var _rollOverComponents:Vector.<IEventDispatcher>;
      
      private var _rendererVO:ClanInvitesWindowAbstractItemVO = null;
      
      public function ClanInvitesWindowAbstractTableItemRenderer()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanInvitesWindowAbstractItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this._commons.removeMultipleHandlers(this._rollOverComponents,MouseEvent.ROLL_OVER,this.onComponentRollOverHandler);
         this._commons.removeMultipleHandlers(this._rollOverComponents,MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this._rollOverComponents.splice(0,this._rollOverComponents.length);
         this._rollOverComponents = null;
         this.messageIcon.dispose();
         this.messageIcon = null;
         this.showMoreButton.removeEventListener(MouseEvent.CLICK,this.onShowMoreButtonClickHandler);
         this.showMoreButton.dispose();
         this.showMoreButton = null;
         this.messageArea = null;
         this.personalRatingTF = null;
         this.battlesCountTF = null;
         this.winsTF = null;
         this.awgExpTF = null;
         this.statusTF = null;
         this._rendererVO = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.onDataUpdated();
         }
      }
      
      protected function onDataUpdated() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this._rendererVO != null;
         var _loc2_:Boolean = _loc1_ && this._rendererVO.hasShowMoreButton;
         var _loc3_:Boolean = _loc1_ && !_loc2_;
         this.personalRatingTF.visible = _loc3_;
         this.battlesCountTF.visible = _loc3_;
         this.winsTF.visible = _loc3_;
         this.awgExpTF.visible = _loc3_;
         this.statusTF.visible = _loc3_;
         this.messageIcon.visible = _loc3_;
         this.showMoreButton.visible = _loc1_ && _loc2_;
         if(_loc1_)
         {
            if(!_loc2_)
            {
               this.personalRatingTF.htmlText = this._rendererVO.personalRating;
               this.battlesCountTF.htmlText = this._rendererVO.battlesCount;
               this.winsTF.htmlText = this._rendererVO.wins;
               this.awgExpTF.htmlText = this._rendererVO.awgExp;
               this.statusTF.htmlText = this._rendererVO.status.text;
               this.messageIcon.visible = StringUtils.isNotEmpty(this._rendererVO.messageTooltip);
               this.messageIcon.source = RES_ICONS.MAPS_ICONS_CLANS_INVITESWINDOW_ICON_INVITE_MESSAGE;
            }
            else
            {
               this.showMoreButton.enabled = this._rendererVO.showMoreButtonEnabled;
            }
         }
      }
      
      override protected function configUI() : void
      {
         var _loc1_:InteractiveObject = null;
         super.configUI();
         this._rollOverComponents = new <IEventDispatcher>[this.messageArea,this.statusTF];
         this.onConfigUI();
         this._commons.updateChildrenMouseEnabled(this,false);
         for each(_loc1_ in this._rollOverComponents)
         {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
            _loc1_.mouseEnabled = true;
         }
      }
      
      protected function addRollOverComponent(param1:IEventDispatcher) : void
      {
         this._rollOverComponents.push(param1);
      }
      
      protected function onConfigUI() : void
      {
         this.showMoreButton.caps = false;
         this.showMoreButton.autoSize = TextFieldAutoSize.CENTER;
         this.showMoreButton.label = CLANS.CLANINVITESWINDOW_TABLE_SHOWMORE;
         this.showMoreButton.addEventListener(MouseEvent.CLICK,this.onShowMoreButtonClickHandler);
         this.showMoreButton.visible = false;
      }
      
      protected function onComponentRollOverHandlerImpl(param1:IEventDispatcher) : void
      {
         if(this._rendererVO != null)
         {
            if(param1 == this.messageArea)
            {
               this.showComplexTooltip(this._rendererVO.messageTooltip);
            }
            else if(param1 == this.statusTF)
            {
               this.showComplexTooltip(this._rendererVO.status.tooltip);
            }
         }
      }
      
      protected function showComplexTooltip(param1:String) : void
      {
         var _loc2_:ITooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,TOOLTIP_MAX_WIDTH);
         App.toolTipMgr.showComplex(param1,_loc2_);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      private function onShowMoreButtonClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ClanTableRendererItemEvent(ClanTableRendererItemEvent.SHOW_MORE_CLICKED,true));
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         this.onComponentRollOverHandlerImpl(InteractiveObject(param1.target));
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
