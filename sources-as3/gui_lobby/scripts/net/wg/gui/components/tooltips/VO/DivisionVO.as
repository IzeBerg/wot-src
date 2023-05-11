package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DivisionVO extends DAAPIDataClass
   {
       
      
      private var _divisName:String = "";
      
      private var _divisLevels:String = "";
      
      private var _divisBonus:String = "";
      
      private var _divisPlayers:String = "";
      
      private var _divisLegionnaires:String = "";
      
      private var _divisTime:String = "";
      
      private var _dailyBonus:String = "";
      
      private var _isSortie:Boolean = false;
      
      public function DivisionVO(param1:Object)
      {
         super(param1);
      }
      
      public function get divisName() : String
      {
         return this._divisName;
      }
      
      public function set divisName(param1:String) : void
      {
         this._divisName = param1;
      }
      
      public function get divisLevels() : String
      {
         return this._divisLevels;
      }
      
      public function set divisLevels(param1:String) : void
      {
         this._divisLevels = param1;
      }
      
      public function get divisBonus() : String
      {
         return this._divisBonus;
      }
      
      public function set divisBonus(param1:String) : void
      {
         this._divisBonus = param1;
      }
      
      public function get divisPlayers() : String
      {
         return this._divisPlayers;
      }
      
      public function set divisPlayers(param1:String) : void
      {
         this._divisPlayers = param1;
      }
      
      public function get divisLegionnaires() : String
      {
         return this._divisLegionnaires;
      }
      
      public function set divisLegionnaires(param1:String) : void
      {
         this._divisLegionnaires = param1;
      }
      
      public function get divisTime() : String
      {
         return this._divisTime;
      }
      
      public function set divisTime(param1:String) : void
      {
         this._divisTime = param1;
      }
      
      public function get dailyBonus() : String
      {
         return this._dailyBonus;
      }
      
      public function set dailyBonus(param1:String) : void
      {
         this._dailyBonus = param1;
      }
      
      public function get isSortie() : Boolean
      {
         return this._isSortie;
      }
      
      public function set isSortie(param1:Boolean) : void
      {
         this._isSortie = param1;
      }
   }
}
