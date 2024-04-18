package net.wg.gui.lobby.clans.profile.views
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapPromoVO;
   import net.wg.infrastructure.base.meta.IClanProfileGlobalMapPromoViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileGlobalMapPromoViewMeta;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ClanProfileGlobalMapPromoView extends ClanProfileGlobalMapPromoViewMeta implements IClanProfileGlobalMapPromoViewMeta
   {
      
      private static const INV_LAYOUT:String = "InvLayout";
      
      private static const DESCRIPTION_GAP:int = 6;
      
      private static const INFO_LIK_GAP:int = 18;
      
      private static const MAP_LINK_GAP:int = 4;
       
      
      public var background:UILoaderAlt = null;
      
      public var headerTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var infoLink:HyperLink = null;
      
      public var mapLink:HyperLink = null;
      
      private var _data:ClanProfileGlobalMapPromoVO = null;
      
      private var _commons:ICommons = null;
      
      public function ClanProfileGlobalMapPromoView()
      {
         super();
      }
      
      override protected function setData(param1:ClanProfileGlobalMapPromoVO) : void
      {
         this._data = param1;
         invalidateData();
         validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._commons = App.utils.commons;
         this.infoLink.addEventListener(ButtonEvent.CLICK,this.onInfoLinkClickHandler);
         this.mapLink.addEventListener(ButtonEvent.CLICK,this.onMapLinkClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.infoLink.removeEventListener(ButtonEvent.CLICK,this.onInfoLinkClickHandler);
         this.infoLink.dispose();
         this.infoLink = null;
         this.mapLink.removeEventListener(ButtonEvent.CLICK,this.onMapLinkClickHandler);
         this.mapLink.dispose();
         this.mapLink = null;
         this.headerTF = null;
         this.descriptionTF = null;
         this.background.dispose();
         this.background = null;
         this._commons = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.headerTF.htmlText = this._data.header;
            this.descriptionTF.htmlText = this._data.description;
            this.infoLink.label = this._data.infoLinkLabel;
            this.mapLink.label = this._data.mapLinkLabel;
            this.background.source = this._data.background;
            invalidate(INV_LAYOUT);
         }
         if(isInvalid(INV_LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      private function updateLayout() : void
      {
         this._commons.updateTextFieldSize(this.headerTF,false);
         this._commons.updateTextFieldSize(this.descriptionTF,false);
         var _loc1_:Number = this.headerTF.height + DESCRIPTION_GAP + this.descriptionTF.height + INFO_LIK_GAP + this.infoLink.height + MAP_LINK_GAP + this.mapLink.height;
         this.headerTF.y = height - _loc1_ >> 1;
         this.descriptionTF.y = this.headerTF.y + this.headerTF.height + DESCRIPTION_GAP;
         this.infoLink.y = this.descriptionTF.y + this.descriptionTF.height + INFO_LIK_GAP;
         this.mapLink.y = this.infoLink.y + this.infoLink.height + MAP_LINK_GAP;
         this.infoLink.validateNow();
         this.mapLink.validateNow();
      }
      
      private function onMapLinkClickHandler(param1:ButtonEvent) : void
      {
         showMapS();
      }
      
      private function onInfoLinkClickHandler(param1:ButtonEvent) : void
      {
         showInfoS();
      }
   }
}
