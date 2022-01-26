package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.components.controls.ResizableTileList;
   import net.wg.gui.lobby.components.AbstractPopoverWithScrollableComponentPanel;
   import net.wg.gui.lobby.missions.data.MissionConditionDetailsVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class MissionDetailsAwardsPanel extends AbstractPopoverWithScrollableComponentPanel
   {
      
      private static const COLUMN_COUNT:int = 5;
      
      private static const ICON_GAP:int = -25;
       
      
      public var conditionIcon:IImage;
      
      private var _tileList:ResizableTileList;
      
      private var _data:MissionConditionDetailsVO;
      
      public function MissionDetailsAwardsPanel()
      {
         super();
      }
      
      override public function setData(param1:IDAAPIDataClass) : void
      {
         this._data = MissionConditionDetailsVO(param1);
         super.setData(param1);
      }
      
      override protected function onDispose() : void
      {
         scrollpane.target = null;
         scrollpane.removeChild(DisplayObject(this._tileList));
         this._tileList.dispose();
         this._tileList = null;
         this.conditionIcon.removeEventListener(Event.CHANGE,this.onConditionIconChangeHandler);
         this.conditionIcon.dispose();
         this.conditionIcon = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tileList = App.utils.classFactory.getComponent(Linkages.MISSION_DETAILS_AWARDS_TILE_LIST_UI,ResizableTileList);
         this._tileList.itemRendererName = MISSIONS_ALIASES.ACHIEVEMENT_RENDERER;
         this._tileList.padding = new Padding(10,0,0,0);
         this._tileList.columnCount = COLUMN_COUNT;
         this._tileList.direction = DirectionMode.VERTICAL;
         this._tileList.x = body.width - this._tileList.width >> 1;
         scrollpane.addChild(DisplayObject(this._tileList));
         scrollpane.target = this._tileList;
         scrollpane.height = body.height - scrollpane.y;
         this.conditionIcon.addEventListener(Event.CHANGE,this.onConditionIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(vo != null && isInvalid(InvalidationType.DATA))
         {
            this.conditionIcon.source = this._data.icon;
            this._tileList.dataProvider = this._data.conditionList;
         }
      }
      
      override protected function get header() : String
      {
         return this._data.description;
      }
      
      private function onConditionIconChangeHandler(param1:Event) : void
      {
         var _loc2_:int = this.conditionIcon.width + labelTf.textWidth + ICON_GAP;
         this.conditionIcon.x = body.width - _loc2_ >> 1;
         labelTf.x = this.conditionIcon.x + this.conditionIcon.width + ICON_GAP;
      }
   }
}
