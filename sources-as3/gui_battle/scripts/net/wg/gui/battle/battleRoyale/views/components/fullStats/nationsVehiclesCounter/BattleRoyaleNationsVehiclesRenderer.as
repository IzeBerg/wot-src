package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Linkages;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.TileList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   
   public class BattleRoyaleNationsVehiclesRenderer extends UIComponent
   {
      
      private static const TILE_LIST_Y:uint = 10;
      
      private static const TILE_LIST_Y_BIG:uint = 5;
      
      private static const SEPARATOR_PADDING_BOTTOM:uint = 10;
      
      private static const SEPARATOR_PADDING_BOTTOM_BIG:uint = 5;
      
      private static const VEHICLES_COUNT_TF_SIZE_SMALL:uint = 15;
      
      private static const ICON_OFFSET:int = -2;
      
      private static const TEXT_OFFSET:int = -4;
      
      private static const SMALL_RESOLUTION_OFFSET:int = -4;
      
      private static const MAX_ROWS:uint = 3;
      
      private static const MAX_COLUMNS:uint = 10;
      
      private static const NATION_INV:String = "nationInv";
      
      private static const VEHICLES_COUNT_INV:String = "vehiclesCountInv";
       
      
      public var nationIcon:MovieClip = null;
      
      public var vehiclesCountTF:TextField = null;
      
      public var tileList:TileList = null;
      
      public var separator:MovieClip = null;
      
      private var _nation:String = "";
      
      private var _vehiclesCount:String = "";
      
      private var _tileListRowHeight:Number = 0;
      
      private var _vehiclesCountTfDefaultSize:Object;
      
      private var _useSmallLayout:Boolean = false;
      
      private var _textFormat:TextFormat = null;
      
      public function BattleRoyaleNationsVehiclesRenderer()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._tileListRowHeight = this.tileList.height / MAX_ROWS;
         this._vehiclesCountTfDefaultSize = this.vehiclesCountTF.defaultTextFormat.size;
         this._textFormat = new TextFormat();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tileList.itemRenderer = App.utils.classFactory.getClass(Linkages.PLATOON_RENDERER);
         this.tileList.direction = DirectionMode.HORIZONTAL;
      }
      
      override protected function onDispose() : void
      {
         this.nationIcon.stop();
         this.nationIcon = null;
         this.vehiclesCountTF = null;
         this.tileList.dispose();
         this.tileList = null;
         this.separator = null;
         this._textFormat = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(NATION_INV))
         {
            this.nationIcon.gotoAndStop(this._nation);
         }
         if(isInvalid(VEHICLES_COUNT_INV))
         {
            this.vehiclesCountTF.text = this._vehiclesCount;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.layout();
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function layout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:uint = Math.ceil(this.tileList.dataProvider.length / MAX_COLUMNS);
         _loc2_ = this._tileListRowHeight * _loc1_ | 0;
         if(_loc1_ > 1)
         {
            this.tileList.y = TILE_LIST_Y_BIG;
            this.separator.y = _loc2_ + SEPARATOR_PADDING_BOTTOM_BIG | 0;
         }
         else
         {
            this.tileList.y = TILE_LIST_Y;
            this.separator.y = this.vehiclesCountTF.height + SEPARATOR_PADDING_BOTTOM | 0;
         }
         if(this._useSmallLayout)
         {
            this.tileList.y += SMALL_RESOLUTION_OFFSET;
            this.separator.y += SMALL_RESOLUTION_OFFSET << 1;
            this._textFormat.size = VEHICLES_COUNT_TF_SIZE_SMALL;
            this._textFormat.bold = true;
         }
         else
         {
            this._textFormat.size = this._vehiclesCountTfDefaultSize;
            this._textFormat.bold = false;
         }
         this.vehiclesCountTF.defaultTextFormat = this._textFormat;
         this.vehiclesCountTF.setTextFormat(this._textFormat);
         this.nationIcon.y = (this.separator.y - this.nationIcon.height >> 1) + ICON_OFFSET;
         this.vehiclesCountTF.y = (this.separator.y - this.vehiclesCountTF.textHeight >> 1) + TEXT_OFFSET;
      }
      
      override public function get height() : Number
      {
         return this.separator.y + this.separator.height | 0;
      }
      
      public function set useSmallLayout(param1:Boolean) : void
      {
         this._useSmallLayout = param1;
         this.layout();
      }
      
      public function set separatorVisible(param1:Boolean) : void
      {
         this.separator.visible = param1;
      }
      
      public function set vehiclesCount(param1:String) : void
      {
         if(this._vehiclesCount != param1)
         {
            this._vehiclesCount = param1;
            invalidate(VEHICLES_COUNT_INV);
         }
      }
      
      public function set nation(param1:String) : void
      {
         if(this._nation != param1)
         {
            this._nation = param1;
            invalidate(NATION_INV);
         }
      }
      
      public function set dataProvider(param1:DataProvider) : void
      {
         this.tileList.dataProvider = param1;
         invalidateData();
      }
   }
}
