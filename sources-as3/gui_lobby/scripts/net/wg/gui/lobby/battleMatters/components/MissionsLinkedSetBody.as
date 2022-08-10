package net.wg.gui.lobby.battleMatters.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleMatters.data.MissionLinkedSetBodyVO;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.gui.lobby.missions.components.MissionPackMarathonBody;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class MissionsLinkedSetBody extends MissionPackMarathonBody implements IPopOverCaller
   {
      
      private static const DECORATION_WIDTH_MIN:int = 1023;
      
      private static const DECORATION_HEIGHT_MIN:int = 272;
      
      private static const DECORATION_WIDTH_MAX:int = 1318;
      
      private static const DECORATION_HEIGHT_MAX:int = 350;
      
      private static const TITLE_OFFSET:int = 400;
      
      private static const AWARD_OFFSET:int = 255;
      
      private static const CARD_OFFSET:int = 280;
       
      
      public var title:TextField = null;
      
      public var description:TextField = null;
      
      public var btnUseToken:ISoundButtonEx = null;
      
      public var award:MovieClip = null;
      
      public var uiDecoration:UILoaderAlt = null;
      
      private var _eventID:String = "";
      
      public function MissionsLinkedSetBody()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnUseToken.addEventListener(ButtonEvent.CLICK,this.onBtnUseTokenClickHandler);
         this.btnUseToken.usePreventUpdateTextScale = true;
         this.award.mouseEnabled = this.award.mouseChildren = false;
         this.uiDecoration.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.autoSize = false;
         this.uiDecoration.mouseEnabled = this.uiDecoration.mouseChildren = false;
         this.title.mouseEnabled = false;
         this.description.mouseEnabled = false;
         mouseEnabled = false;
      }
      
      override protected function setItemRenderer() : void
      {
         missionsList.itemRenderer = App.utils.classFactory.getClass(QUESTS_ALIASES.MISSIONS_LINKED_SET_CARD_RENDERER_LINKAGE);
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.description = null;
         this.award = null;
         this.btnUseToken.removeEventListener(ButtonEvent.CLICK,this.onBtnUseTokenClickHandler);
         this.btnUseToken.dispose();
         this.btnUseToken = null;
         this.uiDecoration.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this._eventID = null;
         super.onDispose();
      }
      
      override protected function getContentHeight() : int
      {
         var _loc1_:int = Boolean(missionsList.height) ? int(missionsList.height + LIST_PADDING_BOTTOM_MIN) : int(0);
         return CARD_OFFSET + (!!dummy.visible ? dummy.height : _loc1_);
      }
      
      override public function get height() : Number
      {
         return maskMc.height;
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:MissionLinkedSetBodyVO = null;
         if(param1 != null)
         {
            _loc2_ = MissionLinkedSetBodyVO(param1);
            this._eventID = _loc2_.eventID;
            this.btnUseToken.label = _loc2_.buttonUseTokenLabel;
            this.btnUseToken.enabled = _loc2_.isButtonUseTokenEnabled;
            this.title.visible = StringUtils.isNotEmpty(_loc2_.title);
            if(this.title.visible)
            {
               this.title.htmlText = _loc2_.title;
            }
            this.description.visible = StringUtils.isNotEmpty(_loc2_.description);
            if(this.description.visible)
            {
               this.description.htmlText = _loc2_.description;
            }
            this.uiDecoration.visible = StringUtils.isNotEmpty(_loc2_.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = _loc2_.uiDecoration;
            }
         }
         super.update(param1);
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.btnUseToken);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.btnUseToken);
      }
      
      override protected function get dataClass() : Class
      {
         return MissionLinkedSetBodyVO;
      }
      
      private function updateBgLoaderSize() : void
      {
         this.uiDecoration.width = !!isBigWidth() ? Number(DECORATION_WIDTH_MAX) : Number(DECORATION_WIDTH_MIN);
         this.uiDecoration.height = !!isBigWidth() ? Number(DECORATION_HEIGHT_MAX) : Number(DECORATION_HEIGHT_MIN);
         this.uiDecoration.x = width - this.uiDecoration.width >> 1;
      }
      
      override protected function updateContentWidth() : void
      {
         super.updateContentWidth();
         dummy.y = missionsList.y = CARD_OFFSET;
         this.title.x = this.description.x = this.btnUseToken.x = (width >> 1) - TITLE_OFFSET;
         this.award.x = (width >> 1) + AWARD_OFFSET;
         if(this.uiDecoration.visible)
         {
            this.updateBgLoaderSize();
         }
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         this.updateBgLoaderSize();
      }
      
      private function onBtnUseTokenClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TypeEvent(TypeEvent.LINKED_SET_USE_TOKEN,this._eventID,true));
         }
      }
   }
}
