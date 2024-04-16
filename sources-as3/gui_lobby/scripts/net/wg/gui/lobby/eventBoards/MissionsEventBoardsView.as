package net.wg.gui.lobby.eventBoards
{
   import flash.events.Event;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.eventBoards.components.MaintenanceComponent;
   import net.wg.gui.lobby.eventBoards.data.MissionsEventBoardsPackVO;
   import net.wg.gui.lobby.eventBoards.events.ServerEvent;
   import net.wg.gui.lobby.eventBoards.events.TypeEvent;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import net.wg.infrastructure.base.meta.IMissionsEventBoardsViewMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsEventBoardsViewMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionsEventBoardsView extends MissionsEventBoardsViewMeta implements IMissionsEventBoardsViewMeta
   {
      
      private static const PARTICIPATE_CLICK:String = "participateClick";
      
      private static const ORDER_CLICK:String = "orderClick";
      
      private static const TECHNIQUE_CLICK:String = "techniqueClick";
      
      private static const AWARD_CLICK:String = "awardClick";
      
      private static const REGISTRATION_CLICK:String = "registrationClick";
      
      private static const RATING_CLICK:String = "ratingClick";
      
      private static const SERVER_CLICK:String = "serverClick";
      
      private static const REFRESH_CLICK:String = "refreshClick";
      
      private static const SCROLL_STEP:int = 4;
      
      private static const INV_SCROLL_POSITION:String = "InvScrollPosition";
       
      
      public var maintenanceCmp:MaintenanceComponent = null;
      
      private var _playFadeInTweenEnabled:Boolean = true;
      
      private var _idFieldName:String = "";
      
      private var _itemId:String = "";
      
      public function MissionsEventBoardsView()
      {
         super();
      }
      
      override public function as_scrollToItem(param1:String, param2:String) : void
      {
         this._idFieldName = param1;
         this._itemId = param2;
         list.scrollToIndex(0);
         scrollBar.position = list.maxVerticalScrollPosition;
         invalidate(INV_SCROLL_POSITION);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(PARTICIPATE_CLICK,this.onBtnParticipateClickHandler);
         addEventListener(ORDER_CLICK,this.onBtnOrderClickHandler);
         addEventListener(TECHNIQUE_CLICK,this.onBtnTechniqueClickHandler);
         addEventListener(AWARD_CLICK,this.onBtnAwardClickHandler);
         addEventListener(REGISTRATION_CLICK,this.onBtnRegistrationClickHandler);
         addEventListener(RATING_CLICK,this.onBtnRatingClickHandler);
         addEventListener(SERVER_CLICK,this.onBtnServerClickHandler);
         addEventListener(REFRESH_CLICK,this.onBtnRefreshClickHandler);
         addEventListener(MissionHeaderEvent.COLLAPSE,this.onCollapseHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.maintenanceCmp.setSize(App.appWidth,App.appHeight);
         }
         if(isInvalid(INV_SCROLL_POSITION) && this._idFieldName != Values.EMPTY_STR && this._itemId != Values.EMPTY_STR)
         {
            list.scrollToEvent(this._idFieldName,this._itemId);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.maintenanceCmp,Aliases.LOBBY_EVENT_BOARDS_MAINTENANCE);
         this.maintenanceCmp.setSize(App.appWidth,App.appHeight);
         this.maintenanceCmp.visible = false;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(PARTICIPATE_CLICK,this.onBtnParticipateClickHandler);
         removeEventListener(ORDER_CLICK,this.onBtnOrderClickHandler);
         removeEventListener(TECHNIQUE_CLICK,this.onBtnTechniqueClickHandler);
         removeEventListener(AWARD_CLICK,this.onBtnAwardClickHandler);
         removeEventListener(REGISTRATION_CLICK,this.onBtnRegistrationClickHandler);
         removeEventListener(RATING_CLICK,this.onBtnRatingClickHandler);
         removeEventListener(SERVER_CLICK,this.onBtnServerClickHandler);
         removeEventListener(REFRESH_CLICK,this.onBtnRefreshClickHandler);
         removeEventListener(MissionHeaderEvent.COLLAPSE,this.onCollapseHandler);
         this.maintenanceCmp = null;
         super.onDispose();
      }
      
      override protected function playFadeInTween() : void
      {
         if(this._playFadeInTweenEnabled)
         {
            alpha = 0;
            if(!_hasBeenShownBefore)
            {
               _hasBeenShownBefore = true;
            }
            else
            {
               setFadeInTween(SMALL_FADE_IN_DELAY);
            }
         }
         else
         {
            this._playFadeInTweenEnabled = true;
         }
      }
      
      override protected function getPageSize() : int
      {
         return list.height / SCROLL_STEP;
      }
      
      public function as_setMaintenance(param1:Boolean, param2:String, param3:String, param4:String) : void
      {
         this.maintenanceCmp.visible = param1;
         this.maintenanceCmp.setMessage(param2,param3);
         this.maintenanceCmp.setLabel(param4);
         list.alpha = !!param1 ? Number(0) : Number(1);
         scrollBar.alpha = !!param1 ? Number(0) : Number(1);
      }
      
      public function as_setPlayFadeInTweenEnabled(param1:Boolean) : void
      {
         this._playFadeInTweenEnabled = param1;
      }
      
      override protected function get dataProviderClass() : Class
      {
         return MissionsEventBoardsPackVO;
      }
      
      private function onBtnParticipateClickHandler(param1:TypeEvent) : void
      {
         participateClickS(param1.id);
      }
      
      private function onBtnOrderClickHandler(param1:TypeEvent) : void
      {
         orderClickS(param1.id);
      }
      
      private function onBtnTechniqueClickHandler(param1:TypeEvent) : void
      {
         techniqueClickS(param1.id);
      }
      
      private function onBtnAwardClickHandler(param1:TypeEvent) : void
      {
         awardClickS(param1.id);
      }
      
      private function onBtnRegistrationClickHandler(param1:TypeEvent) : void
      {
         registrationClickS(param1.id);
      }
      
      private function onBtnRatingClickHandler(param1:Event) : void
      {
         openBoardViewS();
      }
      
      private function onBtnServerClickHandler(param1:ServerEvent) : void
      {
         serverClickS(param1.id,param1.server);
      }
      
      private function onBtnRefreshClickHandler(param1:Event) : void
      {
         this.maintenanceCmp.visible = false;
         this._playFadeInTweenEnabled = false;
      }
      
      private function onCollapseHandler(param1:MissionHeaderEvent) : void
      {
         expandS(param1.missionId,!param1.isCollapsed);
      }
   }
}
