package net.wg.gui.battle.views.battleMessenger
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleSmileyMap implements IDisposable
   {
       
      
      private var _map:Array = null;
      
      public function BattleSmileyMap()
      {
         super();
         var _loc1_:BitmapData = this.getBitmapData("smileyHappyUI");
         var _loc2_:BitmapData = this.getBitmapData("smileyHmmUI");
         var _loc3_:BitmapData = this.getBitmapData("smileyMadUI");
         var _loc4_:BitmapData = this.getBitmapData("smileyMadahUI");
         var _loc5_:BitmapData = this.getBitmapData("smileyNormUI");
         var _loc6_:BitmapData = this.getBitmapData("smileyOhUI");
         var _loc7_:BitmapData = this.getBitmapData("smileySadUI");
         var _loc8_:BitmapData = this.getBitmapData("smileyTongueUI");
         var _loc9_:BitmapData = this.getBitmapData("smileyWinkUI");
         var _loc10_:BitmapData = this.getBitmapData("smileyKissUI");
         this._map = [new BattleImageSubstitution(":)",_loc1_),new BattleImageSubstitution("=)",_loc1_),new BattleImageSubstitution(":-)",_loc1_),new BattleImageSubstitution(":\\",_loc2_),new BattleImageSubstitution("=\\",_loc2_),new BattleImageSubstitution(":-\\",_loc2_),new BattleImageSubstitution(":/",_loc2_),new BattleImageSubstitution("=/",_loc2_),new BattleImageSubstitution(":-/",_loc2_),new BattleImageSubstitution(">:|",_loc3_),new BattleImageSubstitution(">=|",_loc3_),new BattleImageSubstitution(">:-|",_loc3_),new BattleImageSubstitution(">:O",_loc4_),new BattleImageSubstitution(">=O",_loc4_),new BattleImageSubstitution(">:-O",_loc4_),new BattleImageSubstitution(">:o",_loc4_),new BattleImageSubstitution(">=o",_loc4_),new BattleImageSubstitution(">:-o",_loc4_),new BattleImageSubstitution(">:0",_loc4_),new BattleImageSubstitution(">=0",_loc4_),new BattleImageSubstitution(">:-0",_loc4_),new BattleImageSubstitution(":|",_loc5_),new BattleImageSubstitution("=|",_loc5_),new BattleImageSubstitution(":-|",_loc5_),new BattleImageSubstitution(":O",_loc6_),new BattleImageSubstitution("=O",_loc6_),new BattleImageSubstitution(":-O",_loc6_),new BattleImageSubstitution(":o",_loc6_),new BattleImageSubstitution("=o",_loc6_),new BattleImageSubstitution(":-o",_loc6_),new BattleImageSubstitution("=0",_loc6_),new BattleImageSubstitution(":-0",_loc6_),new BattleImageSubstitution(":(",_loc7_),new BattleImageSubstitution("=(",_loc7_),new BattleImageSubstitution(":-(",_loc7_),new BattleImageSubstitution(":P",_loc8_),new BattleImageSubstitution("=P",_loc8_),new BattleImageSubstitution(":-P",_loc8_),new BattleImageSubstitution(":*",_loc10_),new BattleImageSubstitution("=*",_loc10_),new BattleImageSubstitution(":-*",_loc10_),new BattleImageSubstitution(";)",_loc9_),new BattleImageSubstitution(";-)",_loc9_)];
      }
      
      public function dispose() : void
      {
         var _loc1_:BattleImageSubstitution = null;
         for each(_loc1_ in this._map)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._map.splice(0,this._map.length);
         this._map = null;
      }
      
      public function mapText(param1:TextField) : void
      {
         TextFieldEx.setImageSubstitutions(param1,this._map);
      }
      
      private function getBitmapData(param1:String) : BitmapData
      {
         return BitmapData(App.utils.classFactory.getObject(param1));
      }
   }
}
