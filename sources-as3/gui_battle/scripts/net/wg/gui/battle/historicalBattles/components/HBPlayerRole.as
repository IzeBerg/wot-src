package net.wg.gui.battle.historicalBattles.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HBPlayerRole extends BattleUIComponent
   {
      
      private static const PATH:String = "img://historical_battles/gui/maps/icons/roles/";
      
      private static const SIZE:String = "/16x16/";
      
      private static const PNG:String = ".png";
       
      
      public var icon:IImage = null;
      
      private var _role:String = "";
      
      private var _color:String = "green";
      
      public function HBPlayerRole()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._role) && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = PATH + this._color + SIZE + this._role + PNG;
         }
      }
      
      public function get role() : String
      {
         return this._role;
      }
      
      public function set role(param1:String) : void
      {
         if(this._role == param1)
         {
            return;
         }
         this._role = param1;
         invalidateData();
      }
      
      public function get color() : String
      {
         return this._color;
      }
      
      public function set color(param1:String) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         invalidateData();
      }
   }
}
