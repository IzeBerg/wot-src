package net.wg.gui.components.icons
{
   public class PlayerActionMarkerController
   {
      
      private static var _instance:PlayerActionMarkerController;
      
      private static var _allowInstantiation:Boolean = false;
       
      
      private var _ACTIONS:Object;
      
      private var _allActions:Array;
      
      public function PlayerActionMarkerController()
      {
         super();
         if(_allowInstantiation)
         {
         }
      }
      
      public static function get instance() : PlayerActionMarkerController
      {
         if(!_instance)
         {
            _allowInstantiation = true;
            _instance = new PlayerActionMarkerController();
            _allowInstantiation = false;
            _instance.init();
         }
         return _instance;
      }
      
      public function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         this._ACTIONS = {};
         this._ACTIONS.common = {};
         this._ACTIONS.myteam = {};
         this._ACTIONS.enemy = {};
         this._ACTIONS.enemy.hunting = 1;
         this._allActions = [];
         for(_loc1_ in this._ACTIONS)
         {
            for(_loc2_ in this._ACTIONS[_loc1_])
            {
               this._allActions.push(_loc2_);
            }
         }
      }
      
      public function get allActions() : Array
      {
         return this._allActions;
      }
      
      public function getActions(param1:String, param2:Number) : Array
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc3_:Array = [];
         for(_loc4_ in this._ACTIONS[param1])
         {
            _loc5_ = this._ACTIONS[param1][_loc4_];
            if(_loc5_ & param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}
