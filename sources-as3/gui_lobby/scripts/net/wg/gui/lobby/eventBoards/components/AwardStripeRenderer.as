package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.eventBoards.data.AwardStripeRendererVO;
   import net.wg.gui.lobby.eventBoards.events.AwardsRendererEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class AwardStripeRenderer extends SoundListItemRenderer
   {
      
      private static const AWARD_RENDERER_WIDTH:uint = 48;
      
      private static const AWARD_RENDERER_HEIGHT:uint = 48;
      
      private static const AWARDS_GAP:uint = 20;
      
      private static const AWARDS_BOTTOM_THRESHOLD:int = 2300;
      
      private static const AWARDS_TOP_THRESHOLD:int = -500;
      
      private static const AWARDS_POSITION_Y:int = 14;
      
      private static const STRIPE_WIDTH:uint = 920;
      
      private static const GROUP_ICON_WIDTH:uint = 92;
      
      private static const GROUP_ICON_GAP:uint = 8;
      
      private static const RANK_WOODEN:uint = 5;
       
      
      public var groupTF:TextField;
      
      public var awardTF:TextField;
      
      public var shadow:MovieClip;
      
      public var awardsGroup:IGroupEx;
      
      public var rendererBg:AwardsRibbonBg = null;
      
      public var groupIcon:UILoaderAlt = null;
      
      private var _rendererData:AwardStripeRendererVO = null;
      
      private var _prevPosition:Number = 0;
      
      private var _id:int = -1;
      
      public function AwardStripeRenderer()
      {
         super();
      }
      
      override public function getData() : Object
      {
         return this._rendererData;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._rendererData = AwardStripeRendererVO(param1);
            this.id = this._rendererData.id;
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
         this.shadow.visible = false;
         mouseChildren = true;
         this.groupTF.autoSize = TextFieldAutoSize.RIGHT;
         this.awardTF.autoSize = TextFieldAutoSize.RIGHT;
         this.awardsGroup.layout = new CenterAlignedGroupLayout(AWARD_RENDERER_WIDTH,AWARD_RENDERER_HEIGHT);
         this.awardsGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.groupIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onGroupIconMouseOverHandler);
         this.groupIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onGroupIconMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.rendererBg.setBackground(this._rendererData.id);
            this.rendererBg.validateNow();
            this.invalidateAwards();
            visible = true;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.groupTF = null;
         this.awardTF = null;
         this.awardsGroup.dispose();
         this.awardsGroup = null;
         this.rendererBg.dispose();
         this.rendererBg = null;
         this.shadow = null;
         this._rendererData = null;
         this.groupIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onGroupIconMouseOverHandler);
         this.groupIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onGroupIconMouseOutHandler);
         this.groupIcon.dispose();
         this.groupIcon = null;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         super.onDispose();
      }
      
      public function showShadow(param1:Boolean) : void
      {
         this.shadow.visible = param1;
      }
      
      private function invalidateAwards() : void
      {
         var _loc1_:Number = NaN;
         if(this._rendererData.icons)
         {
            this.awardTF.visible = true;
            this.groupTF.text = EVENT_BOARDS.EXCEL_GROUP_TITLE;
            this.awardTF.text = EVENT_BOARDS.EXCEL_AWARD_TITLE;
            CenterAlignedGroupLayout(this.awardsGroup.layout).gap = AWARDS_GAP;
            this.groupIcon.visible = true;
            this.groupIcon.source = this._rendererData.groupIcon;
            this.groupIcon.autoSize = true;
            this.awardsGroup.visible = true;
            this.awardsGroup.dataProvider = this._rendererData.icons;
            _loc1_ = (AWARD_RENDERER_WIDTH + AWARDS_GAP) * this.awardsGroup.getProviderLength() - AWARDS_GAP;
            UIComponent(this.awardsGroup).setSize(_loc1_,AWARD_RENDERER_HEIGHT);
            this.awardTF.visible = true;
            this.groupTF.x = STRIPE_WIDTH - this.groupTF.width - GROUP_ICON_WIDTH - this.awardTF.width - this.awardsGroup.width - GROUP_ICON_GAP >> 1;
            this.groupIcon.x = this.groupTF.x + this.groupTF.width + GROUP_ICON_GAP;
            this.awardTF.x = this.groupIcon.x + GROUP_ICON_WIDTH;
            this.awardsGroup.x = Math.round(this.awardTF.x + this.awardTF.width);
            this.awardsGroup.y = AWARDS_POSITION_Y;
            this.awardsGroup.visible = true;
         }
         else if(this._rendererData.id == RANK_WOODEN)
         {
            this.groupTF.text = EVENT_BOARDS.TABLE_STRIPE_WOOD_TITLE;
            this.groupTF.x = STRIPE_WIDTH - this.groupTF.width >> 1;
            this.awardsGroup.dataProvider = null;
            this.awardsGroup.visible = false;
            this.awardTF.visible = false;
            this.groupIcon.visible = false;
         }
         else
         {
            this.groupIcon.visible = true;
            this.groupIcon.source = this._rendererData.groupIcon;
            this.groupIcon.autoSize = true;
            this.groupTF.text = EVENT_BOARDS.EXCEL_GROUP_TITLE;
            this.groupTF.x = STRIPE_WIDTH - this.groupTF.width - GROUP_ICON_WIDTH - GROUP_ICON_GAP >> 1;
            this.groupIcon.x = this.groupTF.x + this.groupTF.width + GROUP_ICON_GAP;
            this.awardsGroup.dataProvider = null;
            this.awardsGroup.visible = false;
            this.awardTF.visible = false;
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         var _loc2_:Number = parent.y + this.y;
         if(this._rendererData && this._prevPosition != _loc2_ && _loc2_ <= AWARDS_BOTTOM_THRESHOLD && _loc2_ >= AWARDS_TOP_THRESHOLD)
         {
            this.visible = _loc2_ >= 0;
            dispatchEvent(new AwardsRendererEvent(AwardsRendererEvent.AWARD_POSITION_CHANGE,_loc2_,this._rendererData));
            this._prevPosition = _loc2_;
         }
      }
      
      private function onGroupIconMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._rendererData)
         {
            App.toolTipMgr.show(this._rendererData.tooltip);
         }
      }
      
      private function onGroupIconMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
