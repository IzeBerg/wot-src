package net.wg.gui.lobby.components.base
{
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.lobby.components.ButtonFiltersGroup;
   import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.controls.Button;
   
   public class ButtonFiltersBase extends Group
   {
      
      private static const ERROR_MSG:String = "buttonLinkage can`t empty.";
       
      
      protected var filterState:int = 0;
      
      private var _buttonFiltersGroup:ButtonFiltersGroup;
      
      private var _buttonLinkage:String;
      
      private var _classFactory:IClassFactory;
      
      public function ButtonFiltersBase()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._buttonFiltersGroup = new ButtonFiltersGroup();
      }
      
      override protected function onDispose() : void
      {
         this._buttonFiltersGroup.dispose();
         this._buttonFiltersGroup = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function resetFilters(param1:int) : void
      {
         var _loc2_:Button = null;
         var _loc3_:ButtonFiltersItemVO = null;
         var _loc4_:int = this._buttonFiltersGroup.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = this._buttonFiltersGroup.getButtonAt(_loc5_);
            _loc3_ = ButtonFiltersItemVO(_loc2_.data);
            _loc2_.selected = (_loc3_.filterValue & param1) > 0;
            _loc5_++;
         }
      }
      
      public function setData(param1:ButtonFiltersVO) : void
      {
         var _loc3_:Button = null;
         var _loc4_:ButtonFiltersItemVO = null;
         this.removeAllButtons();
         this._buttonFiltersGroup.minSelectedCount = param1.minSelectedItems;
         var _loc2_:Vector.<ButtonFiltersItemVO> = param1.items;
         App.utils.asserter.assert(_loc2_.length <= 0 || !StringUtils.isEmpty(this._buttonLinkage),ERROR_MSG);
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = this._classFactory.getComponent(this._buttonLinkage,Button);
            _loc3_.toggle = true;
            this.applyDataToButton(_loc3_,_loc4_);
            addChild(_loc3_);
            this._buttonFiltersGroup.addButton(_loc3_);
         }
      }
      
      protected function removeAllButtons() : void
      {
         removeAllChildren(true);
         this._buttonFiltersGroup.removeAllButtons();
      }
      
      protected function applyDataToButton(param1:Button, param2:ButtonFiltersItemVO) : void
      {
      }
      
      public function get filtersValue() : int
      {
         return this.filterState;
      }
      
      public function get buttonLinkage() : String
      {
         return this._buttonLinkage;
      }
      
      public function set buttonLinkage(param1:String) : void
      {
         this._buttonLinkage = param1;
      }
      
      public function get buttonFiltersGroup() : ButtonFiltersGroup
      {
         return this._buttonFiltersGroup;
      }
   }
}
