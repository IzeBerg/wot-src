package net.wg.gui.battle.views.damagePanel.components.tankman
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
   
   public class TankmenCtrl implements IDamagePanelItemsCtrl
   {
      
      private static const PATTERN_SIMPLE_TANKMAN_NAME:RegExp = /[^\d]*/;
      
      private static const STUN_ANIMATION_DELAY:uint = 300;
      
      private static const MSG:String = "Not such item with name = ";
       
      
      private var _identifiersByType:Object = null;
      
      private var _items:TankmanDumper = null;
      
      private var _order:Vector.<IDamagePanelClickableItem> = null;
      
      private var _disposed:Boolean = false;
      
      public function TankmenCtrl(param1:Array)
      {
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:TankmanIdentifiers = null;
         super();
         this._identifiersByType = {};
         this._items = new TankmanDumper();
         this._identifiersByType[RolesState.COMANDER] = new TankmanIdentifiers(Linkages.TANKMAN_COMANDER,Linkages.TANKMAN_ORANGE_COMANDER);
         this._identifiersByType[RolesState.GUNNER] = new TankmanIdentifiers(Linkages.TANKMAN_GUNNER,Linkages.TANKMAN_ORANGE_GUNNER);
         this._identifiersByType[RolesState.DRIVER] = new TankmanIdentifiers(Linkages.TANKMAN_DRIVER,Linkages.TANKMAN_ORANGE_DRIVER);
         this._identifiersByType[RolesState.RADIOMAN] = new TankmanIdentifiers(Linkages.TANKMAN_RADIST,Linkages.TANKMAN_ORANGE_RADIOMAN);
         this._identifiersByType[RolesState.LOADER] = new TankmanIdentifiers(Linkages.TANKMAN_SHELLMAN,Linkages.TANKMAN_ORANGE_LOADER,-1);
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 3;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc7_ = param1[_loc6_];
            _loc8_ = PATTERN_SIMPLE_TANKMAN_NAME.exec(_loc7_);
            _loc9_ = _loc8_[0];
            App.utils.asserter.assert(_loc9_ != "","Not valid tankmanName");
            _loc10_ = this._identifiersByType[_loc9_];
            if(_loc9_ == RolesState.LOADER && _loc10_.adtXPadding != 0)
            {
               _loc4_ += _loc10_.adtXPadding - _loc3_;
               _loc3_ += _loc5_;
            }
            else
            {
               _loc4_ = 0;
            }
            this._items[_loc7_] = new TankmanAssets(_loc7_,_loc10_.normal,_loc10_.critical,_loc6_,_loc2_,_loc4_);
            _loc6_++;
         }
         this._order = this._items.getItems();
         this._order.sort(sortByXpos);
      }
      
      private static function sortByXpos(param1:TankmanAssets, param2:TankmanAssets) : int
      {
         if(param1.mouseEventHitElement.x < param2.mouseEventHitElement.x)
         {
            return -1;
         }
         if(param1.mouseEventHitElement.x > param2.mouseEventHitElement.x)
         {
            return 1;
         }
         return 0;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._identifiersByType = App.utils.data.cleanupDynamicObject(this._identifiersByType);
         this._identifiersByType = null;
         this._items.dispose();
         this._items = null;
         this._order.splice(0,this._order.length);
         this._order = null;
      }
      
      public function getItemByName(param1:String) : IDamagePanelClickableItem
      {
         var _loc2_:IDamagePanelClickableItem = this._items[param1];
         App.utils.asserter.assertNotNull(_loc2_,MSG + param1);
         return _loc2_;
      }
      
      public function getItems() : Vector.<IDamagePanelClickableItem>
      {
         return this._items.getItems();
      }
      
      public function reset() : void
      {
         var _loc1_:Vector.<IDamagePanelClickableItem> = this._items.getItems();
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_[_loc3_].state = BATTLE_ITEM_STATES.NORMAL;
            _loc3_++;
         }
      }
      
      public function setState(param1:String, param2:String) : void
      {
         var _loc3_:IDamagePanelClickableItem = this._items[param1];
         App.utils.asserter.assertNotNull(_loc3_,MSG + param1);
         _loc3_.state = param2;
      }
      
      public function showDestroyed() : void
      {
         var _loc4_:IDamagePanelClickableItem = null;
         var _loc1_:Vector.<IDamagePanelClickableItem> = this._items.getItems();
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc4_.showDestroyed();
            _loc3_++;
         }
      }
      
      public function showStatus(param1:int, param2:Boolean) : void
      {
         this.showStatusIndicator(param1,true,param2);
      }
      
      public function hideStatus(param1:int, param2:Boolean) : void
      {
         this.showStatusIndicator(param1,false,param2);
      }
      
      private function showStatusIndicator(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc5_:TankmanAssets = null;
         var _loc4_:int = this._order.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = TankmanAssets(this._order[_loc6_]);
            if(param2)
            {
               _loc5_.showStatus(param1,param3,!!param3 ? int(_loc6_ * STUN_ANIMATION_DELAY) : int(0));
            }
            else
            {
               _loc5_.hideStatus(param1,param3);
            }
            _loc6_++;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
