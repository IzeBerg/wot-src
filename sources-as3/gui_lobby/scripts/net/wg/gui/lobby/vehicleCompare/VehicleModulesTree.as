package net.wg.gui.lobby.vehicleCompare
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.sub.ModulesTree;
   import net.wg.gui.lobby.vehicleCompare.events.VehicleModuleItemEvent;
   import net.wg.gui.lobby.vehicleCompare.nodes.ModulesTreeDataProvider;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleModulesTree extends ModulesTree
   {
      
      private static const LINE_COLOR:uint = 8421504;
      
      private static const MODULE_ITEM_NODE:String = "ModuleItemNodeUI";
      
      private static const MODULE_FAKE_ITEM_NODE:String = "ModuleFakeItemNodeUI";
      
      private static const OFFSET_X:int = 15;
       
      
      private var _availableWidth:int = 0;
      
      public function VehicleModulesTree()
      {
         super();
      }
      
      override public function removeItemRenderer(param1:IRenderer) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onItemRendererRollOverHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onItemRendererRollOutHandler);
         param1.removeEventListener(ButtonEvent.CLICK,this.onItemRendererClickHandler);
         super.removeItemRenderer(param1);
      }
      
      override protected function onDrawComplete() : void
      {
         this.updateTreePosition();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         dataProvider = new ModulesTreeDataProvider();
         var _loc1_:IClassFactory = App.utils.classFactory;
         itemNodeClass = _loc1_.getClass(MODULE_ITEM_NODE);
         fakeNodeClass = _loc1_.getClass(MODULE_FAKE_ITEM_NODE);
         rGraphics.arrowRenderer = Linkages.RESEARCH_ITEMS_ARROW;
         rGraphics.unlockedLineColor = LINE_COLOR;
         rGraphics.lockedLineColor = LINE_COLOR;
         rGraphics.premiumLineColor = LINE_COLOR;
         rGraphics.lineThickness = 1;
         maxNodesOnLevel = 6;
      }
      
      override protected function updateLayouts() : void
      {
         super.updateLayouts();
         this.updateTreePosition();
      }
      
      override protected function setupItemRenderer(param1:IRenderer) : void
      {
         super.setupItemRenderer(param1);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onItemRendererRollOverHandler);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onItemRendererRollOutHandler);
         param1.addEventListener(ButtonEvent.CLICK,this.onItemRendererClickHandler);
      }
      
      public function setNodesStates(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:IRenderer = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Number = param1.length;
         var _loc8_:Number = 0;
         while(_loc8_ < _loc2_)
         {
            _loc3_ = param1[_loc8_];
            _loc6_ = _loc3_[0];
            _loc5_ = null;
            _loc4_ = false;
            _loc7_ = _dataProvider.getIndexByID(_loc6_);
            if(_loc7_ > -1 && _dataProvider.length > _loc7_)
            {
               _loc4_ = _dataProvider.setState(_loc7_,0,_loc3_[1]);
               _loc5_ = getNodeByID(_loc6_);
            }
            else
            {
               App.utils.asserter.assert(false,"VehicleModulesTree. Wrong index: " + _loc7_);
            }
            if(_loc4_)
            {
               _loc5_.invalidateNodeState();
            }
            _loc8_++;
         }
      }
      
      private function updateTreePosition() : void
      {
         rGraphics.x = OFFSET_X + (this._availableWidth - rGraphics.width >> 1);
      }
      
      private function dispatchItemEvent(param1:String, param2:Object) : void
      {
         dispatchEvent(new VehicleModuleItemEvent(param1,IRenderer(param2).getID()));
      }
      
      public function get availableWidth() : int
      {
         return this._availableWidth;
      }
      
      public function set availableWidth(param1:int) : void
      {
         if(this._availableWidth == param1)
         {
            return;
         }
         this._availableWidth = param1;
         this.updateTreePosition();
      }
      
      private function onItemRendererClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchItemEvent(VehicleModuleItemEvent.MODULE_ITEM_CLICKED,param1.target);
      }
      
      private function onItemRendererRollOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new VehicleModuleItemEvent(VehicleModuleItemEvent.MODULE_ITEM_HOVERED,0));
      }
      
      private function onItemRendererRollOverHandler(param1:MouseEvent) : void
      {
         this.dispatchItemEvent(VehicleModuleItemEvent.MODULE_ITEM_HOVERED,param1.target);
      }
   }
}
