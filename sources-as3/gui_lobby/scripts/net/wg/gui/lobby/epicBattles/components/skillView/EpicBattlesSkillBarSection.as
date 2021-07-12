package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EpicBattlesSkillBarSection extends UIComponentEx
   {
      
      public static const ACTIVE_STATE:String = "active";
      
      public static const OVER_STATE:String = "on";
      
      public static const OUT_STATE:String = "off";
       
      
      public var hitbox:MovieClip = null;
      
      private var _index:int = -1;
      
      private var _state:String = "active";
      
      public function EpicBattlesSkillBarSection()
      {
         super();
         gotoAndPlay(this._state);
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.hitbox = null;
         super.onDispose();
      }
      
      public function setState(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
   }
}
