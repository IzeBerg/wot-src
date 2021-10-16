package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.battleRoyale.BattleRoyalePage;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleEventHeaderVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventViewHeader extends Sprite implements IDisposable
   {
      
      private static const ICON_SMALL_MARGIN_X:Number = 14;
      
      private static const ICON_BIG_MARGIN_X:Number = 20;
      
      private static const TITLE_OFFSET_Y:Number = -4;
      
      private static const HEADER_BG_BIG_HEIGHT:Number = 170;
      
      private static const HEADER_BG_SMALL_HEIGHT:Number = 100;
      
      private static const CONTENT_SMALL_SIZE:Number = 85;
      
      private static const CONTENT_BIG_SIZE:Number = 164;
       
      
      public var battleIcon:Image = null;
      
      public var titleTF:TextField = null;
      
      public var subTitleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var headerBG:Sprite = null;
      
      private var _isSmallScreenSize:Boolean = false;
      
      private var _battleType:String = "";
      
      public function EventViewHeader()
      {
         super();
         this.initialiaze();
      }
      
      public final function dispose() : void
      {
         this.battleIcon.removeEventListener(Event.CHANGE,this.onBattleIconChangeHandler);
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.titleTF = null;
         this.subTitleTF = null;
         this.descriptionTF = null;
         this.headerBG = null;
      }
      
      public function getContentHeight() : Number
      {
         return !!this._isSmallScreenSize ? Number(CONTENT_SMALL_SIZE) : Number(CONTENT_BIG_SIZE);
      }
      
      public function setData(param1:BattleRoyaleEventHeaderVO) : void
      {
         this.titleTF.text = param1.title;
         this.subTitleTF.text = param1.subTitle;
         this.descriptionTF.text = param1.description;
         App.utils.commons.updateTextFieldSize(this.descriptionTF,false,true);
         if(this._isSmallScreenSize)
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_64x64_all_png(param1.battleType);
         }
         else
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_136x136_all_png(param1.battleType);
         }
         this._battleType = param1.battleType;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.headerBG.width = param1;
         this.headerBG.x = -param1 >> 1;
         this._isSmallScreenSize = param2 <= BattleRoyalePage.SCREEN_SMALL_HEIGHT || param1 <= BattleRoyalePage.SCREEN_SMALL_WIDTH;
         if(this._isSmallScreenSize)
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_64x64_all_png(this._battleType);
         }
         else
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_136x136_all_png(this._battleType);
         }
      }
      
      private function initialiaze() : void
      {
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.battleIcon.addEventListener(Event.CHANGE,this.onBattleIconChangeHandler);
      }
      
      private function onBattleIconChangeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Number = !!this._isSmallScreenSize ? Number(HEADER_BG_SMALL_HEIGHT) : Number(HEADER_BG_BIG_HEIGHT);
         var _loc3_:Number = -this.battleIcon.width >> 1;
         this.battleIcon.x = _loc3_;
         this.battleIcon.y = _loc2_ - this.battleIcon.height >> 1;
         _loc4_ = this.titleTF.textHeight;
         _loc5_ = !!this._isSmallScreenSize ? int(ICON_SMALL_MARGIN_X) : int(ICON_BIG_MARGIN_X);
         this.titleTF.x = _loc3_ - _loc5_ - this.titleTF.width;
         this.subTitleTF.x = _loc3_ - _loc5_ - this.subTitleTF.width;
         var _loc6_:Number = _loc4_ + this.subTitleTF.textHeight;
         this.titleTF.y = (_loc2_ - _loc6_ >> 1) + TITLE_OFFSET_Y;
         this.subTitleTF.y = this.titleTF.y + _loc4_;
         this.descriptionTF.x = _loc3_ + this.battleIcon.width + _loc5_;
         this.descriptionTF.y = _loc2_ - this.descriptionTF.height >> 1;
      }
   }
}
