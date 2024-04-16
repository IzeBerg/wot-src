package net.wg.gui.lobby.premiumMissions.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.events.MissionPremiumEvent;
   import net.wg.gui.lobby.missions.components.MissionPackMarathonBody;
   import net.wg.gui.lobby.premiumMissions.data.MissionPremiumBodyVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionsPremiumBody extends MissionPackMarathonBody
   {
      
      private static const CARD_OFFSET:int = 280;
      
      private static const UI_DECORATION_OFFSET:int = 50;
      
      private static const GLOWLIGHT_OFFSET:int = 36;
      
      private static const CARS_COMPLETE_OFFSET:int = 15;
       
      
      public var title:TextField = null;
      
      public var completeTitle:TextField = null;
      
      public var description:TextField = null;
      
      public var buttonDetails:ISoundButtonEx = null;
      
      public var icon:Image = null;
      
      public var uiDecoration:UILoaderAlt = null;
      
      public var glowlight:Sprite = null;
      
      private var _dataVO:MissionPremiumBodyVO;
      
      public function MissionsPremiumBody()
      {
         super();
      }
      
      override public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            this._dataVO = MissionPremiumBodyVO(param1);
            this.buttonDetails.visible = this.title.visible = this.description.visible = this.icon.visible = this.uiDecoration.visible = this.glowlight.visible = !this._dataVO.hasPremium;
            if(!this._dataVO.hasPremium)
            {
               this.buttonDetails.label = this._dataVO.buttonDetails;
               this.title.htmlText = this._dataVO.title;
               this.description.htmlText = this._dataVO.description;
               this.icon.source = this._dataVO.icon;
               this.uiDecoration.source = this._dataVO.uiDecoration;
            }
            else
            {
               this.completeTitle.htmlText = this._dataVO.completeTitle;
            }
         }
         super.update(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttonDetails.addEventListener(ButtonEvent.CLICK,this.onButtonDetailsClickHandler);
         this.buttonDetails.usePreventUpdateTextScale = true;
         this.icon.mouseEnabled = this.icon.mouseChildren = false;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.uiDecoration.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.autoSize = false;
         this.uiDecoration.mouseEnabled = this.uiDecoration.mouseChildren = false;
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.mouseEnabled = false;
         this.description.autoSize = TextFieldAutoSize.LEFT;
         this.description.mouseEnabled = false;
         this.completeTitle.autoSize = TextFieldAutoSize.LEFT;
         this.completeTitle.mouseEnabled = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.buttonDetails.removeEventListener(ButtonEvent.CLICK,this.onButtonDetailsClickHandler);
         this.buttonDetails.dispose();
         this.buttonDetails = null;
         this.uiDecoration.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this._dataVO = null;
         this.glowlight = null;
         this.title = null;
         this.description = null;
         this.completeTitle = null;
         super.onDispose();
      }
      
      override protected function getContentHeight() : int
      {
         return missionsList.y + missionsList.height + LIST_PADDING_BOTTOM_MIN;
      }
      
      override protected function updateContentWidth() : void
      {
         super.updateContentWidth();
         if(this._dataVO != null)
         {
            if(this._dataVO.hasPremium)
            {
               if(StringUtils.isNotEmpty(this._dataVO.completeTitle))
               {
                  this.completeTitle.x = width - this.completeTitle.width >> 1;
                  missionsList.y = this.completeTitle.y + this.completeTitle.height + CARS_COMPLETE_OFFSET ^ 0;
               }
               else
               {
                  missionsList.y = LIST_PADDING_BOTTOM_MIN;
               }
            }
            else
            {
               missionsList.y = CARD_OFFSET;
               this.title.x = this.description.x = this.buttonDetails.x = width - this.description.width - this.icon.width - UI_DECORATION_OFFSET >> 1;
               this.icon.x = this.description.x + this.description.width + UI_DECORATION_OFFSET;
               this.uiDecoration.x = width - this.uiDecoration.width ^ 0;
               this.glowlight.x = this.icon.x + (this.icon.width - this.glowlight.width >> 1) ^ 0;
               this.glowlight.y = this.icon.y + (this.icon.height - this.glowlight.height >> 1) + GLOWLIGHT_OFFSET ^ 0;
            }
         }
      }
      
      override protected function get dataClass() : Class
      {
         return MissionPremiumBodyVO;
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onButtonDetailsClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new MissionPremiumEvent(MissionPremiumEvent.BUTTON_DETAILS_CLICK));
      }
   }
}
