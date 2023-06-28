package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
   import net.wg.gui.lobby.rankedBattles19.data.WidgetDivisionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class WidgetDivision extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const IMAGE_SIZE_MEDIUM:String = "80x110";
      
      private static const IMAGE_SIZE_SMALL:String = "58x80";
      
      private static const IMAGE_POSITIONS:Object = {};
      
      {
         IMAGE_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = new Point(-40,-55);
         IMAGE_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = new Point(-30,-40);
      }
      
      public var divisionMc:ImageContainer = null;
      
      public var newDivisionMc:ImageContainer = null;
      
      public var infoTexts:MovieClip = null;
      
      private var _data:WidgetDivisionVO = null;
      
      private var _size:String = "medium";
      
      private var _titleTF:TextField = null;
      
      private var _descrTF:TextField = null;
      
      public function WidgetDivision()
      {
         super();
      }
      
      private static function getIcon(param1:String, param2:int) : String
      {
         return RES_ICONS.maps_icons_rankedbattles_divisions_all_all_png(param1,String(param2));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._titleTF = this.infoTexts.title;
         this._descrTF = this.infoTexts.descr;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Point = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._titleTF.htmlText = this._data.title;
               this._descrTF.htmlText = this._data.infoText;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = this._size == RANKEDBATTLES_ALIASES.WIDGET_MEDIUM ? IMAGE_SIZE_MEDIUM : IMAGE_SIZE_SMALL;
               this.divisionMc.setSource(getIcon(_loc1_,this._data.division));
               this.newDivisionMc.setSource(getIcon(_loc1_,this._data.newDivision));
               _loc2_ = IMAGE_POSITIONS[this._size];
               this.divisionMc.setImgPoint(_loc2_);
               this.newDivisionMc.setImgPoint(_loc2_);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.divisionMc.dispose();
         this.divisionMc = null;
         this.newDivisionMc.dispose();
         this.newDivisionMc = null;
         this.infoTexts = null;
         this._titleTF = null;
         this._descrTF = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = WidgetDivisionVO(param1);
            invalidateData();
         }
      }
      
      public function get componentSize() : String
      {
         return this._size;
      }
      
      public function set componentSize(param1:String) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateSize();
         }
      }
   }
}
