package net.wg.gui.lobby.rankedBattles19.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.battleResults.data.RankedBattleSubTaskVO;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattleSubTask extends UIComponentEx implements ISubtaskComponent
   {
      
      private static var _blackWhiteFilters:Array = null;
      
      private static const RENDERER_MIN_HEIGHT:int = 116;
      
      private static const TITLE_PADDING_RIGHT:int = 120;
      
      private static const ICON_CENTER_X:int = 160;
      
      private static const DESCRIPTION_PADDING_LEFT:int = 235;
      
      private static const SHIELD_TF_OFFSET_X:int = 2;
      
      private static const SHIELD_TF_OFFSET_Y:int = -3;
      
      private static const PLATE_ICON_OFFSET_X:int = 2;
      
      private static const PLATE_ICON_OFFSET_Y:int = -3;
      
      private static const LINE_MC_OFFSET_Y:int = 10;
      
      private static const DESCRIPTION_ICON_MIN_WIDTH:int = 30;
      
      private static const DESCRIPTION_ICON_OFFSET_X:int = 10;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var lineMC:MovieClip = null;
      
      public var descriptionIcon:Image = null;
      
      public var icon:Image = null;
      
      public var plateIcon:Image = null;
      
      public var shieldIcon:Image = null;
      
      public var shieldTF:TextField = null;
      
      private var _data:RankedBattleSubTaskVO = null;
      
      public function RankedBattleSubTask()
      {
         super();
         stop();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.descriptionIcon.addEventListener(Event.CHANGE,this.onDescriptionIconChangeHandler);
         this.shieldIcon.addEventListener(Event.CHANGE,this.onShieldIconChangeHandler);
         this.plateIcon.addEventListener(Event.CHANGE,this.onPlateIconChangeHandler);
         this.titleTF.wordWrap = true;
         this.titleTF.autoSize = TextFieldAutoSize.RIGHT;
         this.titleTF.mouseWheelEnabled = false;
         this.descriptionTF.wordWrap = true;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.mouseWheelEnabled = false;
         this.shieldTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.descriptionIcon.removeEventListener(Event.CHANGE,this.onDescriptionIconChangeHandler);
         this.shieldIcon.removeEventListener(Event.CHANGE,this.onShieldIconChangeHandler);
         this.plateIcon.removeEventListener(Event.CHANGE,this.onPlateIconChangeHandler);
         this.titleTF = null;
         this.descriptionTF = null;
         this.lineMC = null;
         this.descriptionIcon.dispose();
         this.descriptionIcon = null;
         this.icon.dispose();
         this.icon = null;
         this.plateIcon.dispose();
         this.plateIcon = null;
         this.shieldIcon.dispose();
         this.shieldIcon = null;
         this.shieldTF = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         super.draw();
         if(this._data)
         {
            _loc1_ = StringUtils.isNotEmpty(this._data.descriptionIcon);
            _loc2_ = StringUtils.isNotEmpty(this._data.shieldIcon);
            _loc3_ = StringUtils.isNotEmpty(this._data.shieldCount);
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTF.htmlText = this._data.title;
               this.icon.source = this._data.icon;
               this.descriptionTF.htmlText = this._data.description;
               if(_loc1_)
               {
                  this.descriptionIcon.source = this._data.descriptionIcon;
               }
               this.descriptionIcon.visible = _loc1_;
               if(_loc2_)
               {
                  this.shieldIcon.source = this._data.shieldIcon;
               }
               this.shieldIcon.visible = _loc2_;
               if(_loc3_)
               {
                  this.shieldTF.text = this._data.shieldCount;
                  this.plateIcon.source = this._data.plateIcon;
               }
               this.shieldTF.visible = this.plateIcon.visible = _loc3_;
               this.updateState();
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.lineMC.y = Math.max(this.descriptionTF.height + LINE_MC_OFFSET_Y | 0,RENDERER_MIN_HEIGHT);
               this.titleTF.x = TITLE_PADDING_RIGHT - this.titleTF.width;
               this.titleTF.y = this.height - this.titleTF.height >> 1;
               this.icon.x = ICON_CENTER_X - (this.icon.width >> 1);
               this.icon.y = this.height - this.icon.height >> 1;
               if(_loc2_)
               {
                  this.shieldIcon.x = ICON_CENTER_X - (this.shieldIcon.width >> 1);
                  this.shieldIcon.y = this.height - this.shieldIcon.height >> 1;
               }
               if(_loc3_)
               {
                  this.plateIcon.x = this.shieldIcon.x + this.shieldIcon.width - this.plateIcon.width + PLATE_ICON_OFFSET_X | 0;
                  this.plateIcon.y = this.shieldIcon.y + PLATE_ICON_OFFSET_Y | 0;
                  this.shieldTF.x = this.plateIcon.x + (this.plateIcon.width - this.shieldTF.width >> 1) + SHIELD_TF_OFFSET_X | 0;
                  this.shieldTF.y = this.shieldIcon.y + SHIELD_TF_OFFSET_Y | 0;
               }
               _loc4_ = DESCRIPTION_PADDING_LEFT;
               if(_loc1_)
               {
                  this.descriptionIcon.x = _loc4_;
                  this.descriptionIcon.y = this.height - this.descriptionIcon.height >> 1;
                  _loc4_ += Math.max(this.descriptionIcon.width,DESCRIPTION_ICON_MIN_WIDTH) + DESCRIPTION_ICON_OFFSET_X;
               }
               this.descriptionTF.x = _loc4_;
               this.descriptionTF.y = this.height - this.descriptionTF.height >> 1;
            }
         }
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._data = RankedBattleSubTaskVO(param1);
         invalidateData();
      }
      
      private function updateState() : void
      {
         if(this._data)
         {
            if(this._data.state == RANKEDBATTLES_ALIASES.RANK_LOST_STATE)
            {
               if(_blackWhiteFilters)
               {
                  this.icon.filters = _blackWhiteFilters;
               }
               else
               {
                  App.utils.commons.setSaturation(this.icon,0);
                  _blackWhiteFilters = this.icon.filters;
               }
            }
            else
            {
               this.icon.filters = null;
            }
         }
      }
      
      override public function get height() : Number
      {
         return this.lineMC.y;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onDescriptionIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onShieldIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onPlateIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
