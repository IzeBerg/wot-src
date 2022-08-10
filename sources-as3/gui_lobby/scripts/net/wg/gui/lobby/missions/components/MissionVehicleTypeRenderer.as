package net.wg.gui.lobby.missions.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.missions.data.MissionVehicleTypeRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MissionVehicleTypeRenderer extends UIComponentEx implements IListItemRenderer, IUpdatable
   {
      
      private static const TILE_WIDTH:uint = 27;
      
      private static const TILE_HEIGHT:uint = 17;
      
      private static const HORIZONTAL_GAP:Number = 13;
      
      private static const VERTICAL_GAP:Number = 8;
      
      private static const HEIGHT:Number = 72;
      
      private static const ICON_GAP:Number = 3;
      
      private static const ITEM_RENDERER:String = "MissionVehicleParamRendererUI";
       
      
      public var imgIcon:Image;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var list:SimpleTileList;
      
      public var bg:MovieClip;
      
      private var _index:uint;
      
      private var _owner:UIComponent;
      
      private var _data:MissionVehicleTypeRendererVO;
      
      public function MissionVehicleTypeRenderer()
      {
         super();
         this.list.itemRenderer = App.utils.classFactory.getClass(ITEM_RENDERER);
         this.list.tileWidth = TILE_WIDTH;
         this.list.tileHeight = TILE_HEIGHT;
         this.list.horizontalGap = HORIZONTAL_GAP;
         this.list.verticalGap = VERTICAL_GAP;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = width;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data != null)
            {
               _loc1_ = this._data.list.length <= 0;
               this.imgIcon.source = this._data.typeIcon;
               this.txtTitle.htmlText = this._data.label;
               this.txtDescription.htmlText = this._data.def;
               App.utils.commons.updateTextFieldSize(this.txtDescription);
               this.txtDescription.visible = _loc1_;
               if(!_loc1_)
               {
                  this.list.dataProvider = this._data.list;
                  this.list.width = (TILE_WIDTH + HORIZONTAL_GAP) * this._data.list.length;
                  this.list.validateNow();
                  this.list.y = this.height - this.list.height >> 1;
               }
               this.txtDescription.y = this.height - this.txtDescription.height >> 1;
               this.txtTitle.y = this.height - this.txtTitle.height >> 1;
               this.imgIcon.y = this.txtTitle.y + ICON_GAP;
               _loc2_ = this.txtDescription.x + this.txtDescription.textWidth;
               _loc3_ = this.list.x + this.list.width;
               width = _loc2_ > _loc3_ ? Number(_loc2_) : Number(_loc3_);
            }
            else
            {
               this.imgIcon.source = null;
               this.txtTitle.text = this.txtDescription.text = Values.EMPTY_STR;
               this.list.dataProvider = null;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.imgIcon.dispose();
         this.imgIcon = null;
         this.list.dispose();
         this.list = null;
         this.txtTitle = null;
         this.txtDescription = null;
         this.bg = null;
         this._data = null;
         this._owner = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = MissionVehicleTypeRendererVO(param1);
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
   }
}
