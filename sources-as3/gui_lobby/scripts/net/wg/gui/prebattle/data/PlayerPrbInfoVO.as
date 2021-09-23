package net.wg.gui.prebattle.data
{
   import net.wg.data.VO.ExtendedUserVO;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.prebattle.constants.PrebattleStateFlags;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import net.wg.infrastructure.interfaces.IColorScheme;
   
   public class PlayerPrbInfoVO extends ExtendedUserVO
   {
       
      
      public var isCurrentPayer:Boolean;
      
      public var hasPermissions:Boolean;
      
      public var hasPermissionsInfo:Boolean;
      
      private var _time:Number;
      
      private var _state:Number;
      
      private var _icon:String = "";
      
      private var _vShortName:String = "";
      
      private var _vLevel:String = "";
      
      private var _dummy:Boolean = false;
      
      private var _vType:String = "";
      
      private var _orderNumber:Number;
      
      private var _isCreator:Boolean;
      
      private var _isExperimentalModule:Boolean = false;
      
      private var _experimentalModuleName:String = "";
      
      public function PlayerPrbInfoVO(param1:Object)
      {
         super(param1);
      }
      
      public function get experimentalModuleName() : String
      {
         return this._experimentalModuleName;
      }
      
      public function set experimentalModuleName(param1:String) : void
      {
         this._experimentalModuleName = param1;
      }
      
      public function get isExperimentalModule() : Boolean
      {
         return this._isExperimentalModule;
      }
      
      public function set isExperimentalModule(param1:Boolean) : void
      {
         this._isExperimentalModule = param1;
      }
      
      override public function get kickId() : Number
      {
         return accID;
      }
      
      public function get time() : Number
      {
         return this._time;
      }
      
      public function set time(param1:Number) : void
      {
         this._time = param1;
      }
      
      public function get state() : Number
      {
         return this._state;
      }
      
      public function set state(param1:Number) : void
      {
         this._state = param1;
      }
      
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function set icon(param1:String) : void
      {
         this._icon = param1;
      }
      
      public function get vShortName() : String
      {
         return this._vShortName;
      }
      
      public function set vShortName(param1:String) : void
      {
         this._vShortName = param1;
      }
      
      public function get vLevel() : String
      {
         return this._vLevel;
      }
      
      public function set vLevel(param1:String) : void
      {
         this._vLevel = param1;
      }
      
      public function get dummy() : Boolean
      {
         return this._dummy;
      }
      
      public function set dummy(param1:Boolean) : void
      {
         this._dummy = param1;
      }
      
      public function get vType() : String
      {
         return this._vType;
      }
      
      public function set vType(param1:String) : void
      {
         this._vType = param1;
      }
      
      public function get orderNumber() : Number
      {
         return this._orderNumber;
      }
      
      public function set orderNumber(param1:Number) : void
      {
         this._orderNumber = param1;
      }
      
      public function get isCreator() : Boolean
      {
         return this._isCreator;
      }
      
      public function set isCreator(param1:Boolean) : void
      {
         this._isCreator = param1;
      }
      
      public function isOffline() : Boolean
      {
         return (this._state & PrebattleStateFlags.OFFLINE) != 0;
      }
      
      public function getStateString() : String
      {
         var _loc1_:String = PrebattleStateString.UNKNOWN;
         if(this._state && this._state != PrebattleStateFlags.UNKNOWN)
         {
            if(this.isOffline())
            {
               _loc1_ = (this._state & PrebattleStateFlags.NOT_READY) != 0 ? PrebattleStateString.OFFLINE : PrebattleStateString.OFFLINE_READY;
            }
            else if(this._state == PrebattleStateFlags.NOT_READY)
            {
               _loc1_ = PrebattleStateString.NOT_READY;
            }
            else if(this._state == PrebattleStateFlags.AFK)
            {
               _loc1_ = PrebattleStateString.AFK;
            }
            else if(this._state == PrebattleStateFlags.READY)
            {
               _loc1_ = PrebattleStateString.READY;
            }
            else if(this._state == PrebattleStateFlags.IN_BATTLE)
            {
               _loc1_ = PrebattleStateString.IN_BATTLE;
            }
         }
         return _loc1_;
      }
      
      public function getCurrentColor() : Number
      {
         var _loc1_:IColorScheme = null;
         if(this.isCreator && !UserTags.isCurrentPlayer(tags))
         {
            _loc1_ = App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAM_COMMANDER);
            return _loc1_.rgb;
         }
         return Boolean(_colors) ? Number(_colors[!!this.isOffline() ? 1 : 0]) : Number(NaN);
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
         }
      }
   }
}
