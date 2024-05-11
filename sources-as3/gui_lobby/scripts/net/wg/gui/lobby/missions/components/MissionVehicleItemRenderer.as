package net.wg.gui.lobby.missions.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.missions.data.MissionVehicleItemRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MissionVehicleItemRenderer extends UIComponentEx implements IListItemRenderer, IUpdatable
   {
      
      private static const PADDING_EMPTY_NAME:int = 3;
      
      private static const HEIGHT:int = 32;
      
      private static const TEXT_HALF_ALPHA:Number = 0.5;
      
      private static const TEXT_FULL_ALPHA:Number = 1;
       
      
      public var imgNation:Image;
      
      public var imgType:Image;
      
      public var imgLevel:Image;
      
      public var imgTank:Image;
      
      public var txtTankName:TextField;
      
      public var bg:MovieClip;
      
      private var _index:uint;
      
      private var _owner:UIComponent;
      
      private var _data:MissionVehicleItemRendererVO;
      
      public function MissionVehicleItemRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.imgLevel.source = this._data.levelIcon;
            this.imgNation.source = this._data.nationIcon;
            this.imgType.source = this._data.typeIcon;
            this.imgTank.source = this._data.vehicleIcon;
            this.txtTankName.htmlText = this._data.vehicleName;
            this.txtTankName.alpha = !!StringUtils.isNotEmpty(this._data.typeIcon) ? Number(TEXT_FULL_ALPHA) : Number(TEXT_HALF_ALPHA);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = width;
            if(this._data != null)
            {
               if(StringUtils.isEmpty(this._data.typeIcon))
               {
                  this.txtTankName.x = this.imgLevel.x + PADDING_EMPTY_NAME;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.imgNation.dispose();
         this.imgNation = null;
         this.imgType.dispose();
         this.imgType = null;
         this.imgLevel.dispose();
         this.imgLevel = null;
         this.imgTank.dispose();
         this.imgTank = null;
         this.txtTankName = null;
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
         this._data = MissionVehicleItemRendererVO(param1);
         invalidateData();
         invalidateSize();
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
