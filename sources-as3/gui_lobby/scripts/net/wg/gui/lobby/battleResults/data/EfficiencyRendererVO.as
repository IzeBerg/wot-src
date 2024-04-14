package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EfficiencyRendererVO extends DAAPIDataClass
   {
      
      private static const ARMOR_NAMES:String = "armorNames";
      
      private static const ARMOR_VALS:String = "armorVals";
      
      private static const DAMAGE_VALS:String = "damageDealtVals";
      
      private static const DAMAGE_NAMES:String = "damageDealtNames";
      
      private static const ASSIST_NAMES:String = "damageAssistedNames";
      
      private static const ASSIST_VALS:String = "damageAssistedVals";
      
      private static const CAPTURE_VALS:String = "captureVals";
      
      private static const CAPTURE_NAMES:String = "captureNames";
      
      private static const DEFENCE_VALS:String = "defenceVals";
      
      private static const DEFENCE_NAMES:String = "defenceNames";
      
      private static const STUN_NAMES:String = "stunNames";
      
      private static const STUN_VALS:String = "stunVals";
       
      
      public var armorTotalItems:int = -1;
      
      public var killCount:int = -1;
      
      public var criticalDevices:String = "";
      
      public var playerFullName:String = "";
      
      public var isAlly:Boolean = false;
      
      public var typeCompDescr:int = -1;
      
      public var damageTotalItems:int = -1;
      
      public var destroyedTankmen:String = "";
      
      public var damageDealt:int = -1;
      
      public var critsCount:String = "";
      
      private var _damageDealtVals:Array;
      
      private var _damageDealtNames:Array;
      
      public var damageAssisted:int = -1;
      
      public var spotted:int = -1;
      
      public var destroyedDevices:String = "";
      
      public var playerRegion:String = "";
      
      public var vehicleId:int = -1;
      
      public var playerName:String = "";
      
      private var _armorNames:Array;
      
      private var _armorVals:Array;
      
      public var playerClan:String = "";
      
      public var isFake:Boolean = false;
      
      public var vehicleName:String = "";
      
      public var piercings:int = -1;
      
      public var deathReason:int = -1;
      
      public var tankIcon:String = "";
      
      public var groupLabel:String = "";
      
      public var baseLabel:String = "";
      
      public var hoveredKind:String = "";
      
      public var isDisabled:Boolean = false;
      
      private var _defenceVals:Array;
      
      private var _captureVals:Array;
      
      private var _captureNames:Array;
      
      private var _defenceNames:Array;
      
      public var captureTotalItems:int = -1;
      
      public var defenceTotalItems:int = -1;
      
      private var _damageAssistedVals:Array;
      
      private var _damageAssistedNames:Array;
      
      public var assistTotalItems:int = -1;
      
      public var isStunDataEnabled:Boolean = false;
      
      public var damageAssistedStun:int = -1;
      
      private var _stunVals:Array;
      
      private var _stunNames:Array;
      
      public function EfficiencyRendererVO(param1:Object)
      {
         this._damageDealtVals = [];
         this._damageDealtNames = [];
         this._armorNames = [];
         this._armorVals = [];
         this._defenceVals = [];
         this._captureVals = [];
         this._captureNames = [];
         this._defenceNames = [];
         this._damageAssistedVals = [];
         this._damageAssistedNames = [];
         this._stunVals = [];
         this._stunNames = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case ARMOR_NAMES:
               this._armorNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._armorNames,param1 + Errors.CANT_NULL);
               return false;
            case ARMOR_VALS:
               this._armorVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._armorVals,param1 + Errors.CANT_NULL);
               return false;
            case DAMAGE_VALS:
               this._damageDealtVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._damageDealtVals,param1 + Errors.CANT_NULL);
               return false;
            case DAMAGE_NAMES:
               this._damageDealtNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._damageDealtNames,param1 + Errors.CANT_NULL);
               return false;
            case ASSIST_NAMES:
               this._damageAssistedNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._damageAssistedNames,param1 + Errors.CANT_NULL);
               return false;
            case ASSIST_VALS:
               this._damageAssistedVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._damageAssistedVals,param1 + Errors.CANT_NULL);
               return false;
            case CAPTURE_VALS:
               this._captureVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._captureVals,param1 + Errors.CANT_NULL);
               return false;
            case CAPTURE_NAMES:
               this._captureNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._captureNames,param1 + Errors.CANT_NULL);
               return false;
            case DEFENCE_VALS:
               this._defenceVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._defenceVals,param1 + Errors.CANT_NULL);
               return false;
            case DEFENCE_NAMES:
               this._defenceNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._defenceNames,param1 + Errors.CANT_NULL);
               return false;
            case STUN_VALS:
               this._stunVals = param2 as Array;
               App.utils.asserter.assertNotNull(this._stunVals,param1 + Errors.CANT_NULL);
               return false;
            case STUN_NAMES:
               this._stunNames = param2 as Array;
               App.utils.asserter.assertNotNull(this._stunNames,param1 + Errors.CANT_NULL);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         this._armorNames.splice(0,this._armorNames.length);
         this._armorNames = null;
         this._armorVals.splice(0,this._armorVals.length);
         this._armorVals = null;
         this._damageDealtVals.splice(0,this._damageDealtVals.length);
         this._damageDealtVals = null;
         this._damageDealtNames.splice(0,this._damageDealtNames.length);
         this._damageDealtNames = null;
         this._damageAssistedNames.splice(0,this._damageAssistedNames.length);
         this._damageAssistedNames = null;
         this._damageAssistedVals.splice(0,this._damageAssistedVals.length);
         this._damageAssistedVals = null;
         this._captureVals.splice(0,this._captureVals.length);
         this._captureVals = null;
         this._captureNames.splice(0,this._captureNames.length);
         this._captureNames = null;
         this._defenceVals.splice(0,this._defenceVals.length);
         this._defenceVals = null;
         this._defenceNames.splice(0,this._defenceNames.length);
         this._defenceNames = null;
         this._stunVals.splice(0,this._stunVals.length);
         this._stunVals = null;
         this._stunNames.splice(0,this._stunNames.length);
         this._stunNames = null;
         super.onDispose();
      }
      
      public function get armorNames() : Array
      {
         return this._armorNames;
      }
      
      public function get armorVals() : Array
      {
         return this._armorVals;
      }
      
      public function get damageDealtVals() : Array
      {
         return this._damageDealtVals;
      }
      
      public function get damageDealtNames() : Array
      {
         return this._damageDealtNames;
      }
      
      public function get damageAssistedNames() : Array
      {
         return this._damageAssistedNames;
      }
      
      public function get defenceVals() : Array
      {
         return this._defenceVals;
      }
      
      public function get captureVals() : Array
      {
         return this._captureVals;
      }
      
      public function get captureNames() : Array
      {
         return this._captureNames;
      }
      
      public function get defenceNames() : Array
      {
         return this._defenceNames;
      }
      
      public function get damageAssistedVals() : Array
      {
         return this._damageAssistedVals;
      }
      
      public function get stunNames() : Array
      {
         return this._stunNames;
      }
      
      public function get stunVals() : Array
      {
         return this._stunVals;
      }
   }
}
