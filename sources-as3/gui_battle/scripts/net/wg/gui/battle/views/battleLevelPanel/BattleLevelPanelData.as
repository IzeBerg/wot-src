package net.wg.gui.battle.views.battleLevelPanel
{
   import net.wg.data.constants.Values;
   
   public class BattleLevelPanelData
   {
      
      public static const DEFAULT_STATE:uint = Values.ZERO;
      
      public static const SET_EXPERIENCE_STATE:uint = 1;
      
      public static const SET_LEVEL_STATE:uint = 2;
      
      public static const SET_IS_MAX_LEVEL_STATE:uint = 3;
       
      
      private var _state:uint = 0;
      
      private var _experience:String = "";
      
      private var _currentExperience:int = 0;
      
      private var _targetExperience:String = "";
      
      private var _expDiff:int = 0;
      
      private var _percent:int = 0;
      
      private var _currentLevel:String = "";
      
      private var _nextLevel:String = "";
      
      private var _playSound:Boolean = false;
      
      public function BattleLevelPanelData(param1:uint)
      {
         super();
         this._state = param1;
      }
      
      public function setExperience(param1:int, param2:String, param3:int, param4:int, param5:Boolean) : void
      {
         this._currentExperience = param1;
         this._targetExperience = param2;
         this._expDiff = param3;
         this._percent = param4;
         this._playSound = param5;
      }
      
      public function setLevel(param1:String, param2:String, param3:String) : void
      {
         this._currentLevel = param1;
         this._nextLevel = param2;
         this._experience = param3;
      }
      
      public function get state() : uint
      {
         return this._state;
      }
      
      public function get experience() : String
      {
         return this._experience;
      }
      
      public function get percent() : int
      {
         return this._percent;
      }
      
      public function get currentLevel() : String
      {
         return this._currentLevel;
      }
      
      public function set currentLevel(param1:String) : void
      {
         this._currentLevel = param1;
      }
      
      public function get nextLevel() : String
      {
         return this._nextLevel;
      }
      
      public function get expDiff() : int
      {
         return this._expDiff;
      }
      
      public function get currentExperience() : int
      {
         return this._currentExperience;
      }
      
      public function get targetExperience() : String
      {
         return this._targetExperience;
      }
      
      public function get playSound() : Boolean
      {
         return this._playSound;
      }
   }
}
