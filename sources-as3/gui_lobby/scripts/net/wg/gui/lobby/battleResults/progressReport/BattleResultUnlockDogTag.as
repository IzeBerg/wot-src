package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.events.ButtonEvent;
   
   public class BattleResultUnlockDogTag extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const BACKGROUND:String = "background";
      
      private static const ENGRAVING:String = "engraving";
      
      private static const UPGRADE:String = "upgrade";
      
      private static const UNLOCK:String = "unlock";
      
      private static const LINK_BTN_OFFSET:int = 5;
       
      
      public var engraving:UILoaderAlt;
      
      public var background:UILoaderAlt;
      
      public var linkBtn:SoundButtonEx;
      
      public var title:TextField;
      
      public var description:TextField;
      
      public var iconUnlock:MovieClip;
      
      public var iconUpgrade:MovieClip;
      
      private var _itemData:BattleResultUnlockDogTagVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function BattleResultUnlockDogTag()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.background.addEventListener(MouseEvent.ROLL_OVER,this.onDogTagRollOverHandler);
         this.background.addEventListener(MouseEvent.ROLL_OUT,this.onDogTagRollOutHandler);
         this.engraving.mouseEnabled = false;
         this.engraving.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.linkBtn.dispose();
         this.linkBtn = null;
         this._itemData.dispose();
         this._itemData = null;
         this.engraving.dispose();
         this.engraving = null;
         this.background.removeEventListener(MouseEvent.ROLL_OVER,this.onDogTagRollOverHandler);
         this.background.removeEventListener(MouseEvent.ROLL_OUT,this.onDogTagRollOutHandler);
         this.background.dispose();
         this.background = null;
         this.title = null;
         this.description = null;
         super.onDispose();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._itemData = new BattleResultUnlockDogTagVO(param1);
         this.buildDogTag();
         this.title.text = this._itemData.title;
         App.utils.commons.moveDsiplObjToEndOfText(this.linkBtn,this.title,LINK_BTN_OFFSET);
         this.description.htmlText = this._itemData.description;
      }
      
      private function buildDogTag() : void
      {
         if(this._itemData.dogTagType == UNLOCK)
         {
            this.iconUnlock.visible = true;
            this.iconUpgrade.visible = false;
            if(this._itemData.unlockType == ENGRAVING)
            {
               this.engraving.visible = true;
               this.background.source = RES_ICONS.MAPS_ICONS_DOGTAGS_MINI_BACKGROUNDS_BACKGROUND_66_0;
               this.engraving.source = RES_ICONS.maps_icons_dogtags_mini_engravings_all_png(this._itemData.imageSrc);
               return;
            }
            if(this._itemData.unlockType == BACKGROUND)
            {
               this.background.source = RES_ICONS.maps_icons_dogtags_mini_backgrounds_all_png(this._itemData.imageSrc);
               this.engraving.visible = false;
               return;
            }
         }
         if(this._itemData.dogTagType == UPGRADE)
         {
            this.iconUpgrade.visible = true;
            this.iconUnlock.visible = false;
            this.engraving.visible = true;
            this.background.source = RES_ICONS.MAPS_ICONS_DOGTAGS_MINI_BACKGROUNDS_BACKGROUND_0_0;
            this.engraving.source = RES_ICONS.maps_icons_dogtags_mini_engravings_all_png(this._itemData.imageSrc);
            return;
         }
         App.utils.asserter.assert(false,"Unsupported unlock/type combination");
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new DogTagLinkEvent(this._itemData.componentId));
      }
      
      private function onDogTagRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.DOG_TAGS_INFO,null,this._itemData.componentId);
      }
      
      private function onDogTagRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
