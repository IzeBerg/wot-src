package net.wg.gui.battle.views.radialMenu.components
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RADIAL_MENU_CONSTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Icons extends MovieClip implements IDisposable
   {
       
      
      public var waypointIcon:MovieClip = null;
      
      public var attentionIcon:MovieClip = null;
      
      public var spgAreaIcon:MovieClip = null;
      
      public var supportingAllyIcon:MovieClip = null;
      
      public var helpmeexIcon:MovieClip = null;
      
      public var sosIcon:MovieClip = null;
      
      public var defendBaseIcon:MovieClip = null;
      
      public var defendingBaseIcon:MovieClip = null;
      
      public var noIcon:MovieClip = null;
      
      public var reloadIcon:MovieClip = null;
      
      public var attackIcon:MovieClip = null;
      
      public var yesIcon:MovieClip = null;
      
      public var turnbackIcon:MovieClip = null;
      
      public var supportIcon:MovieClip = null;
      
      public var thankYouIcon:MovieClip = null;
      
      public var attackBaseIcon:MovieClip = null;
      
      public var attackingBaseIcon:MovieClip = null;
      
      public var attackHQIcon:MovieClip = null;
      
      public var attackingHQIcon:MovieClip = null;
      
      public var defendHQIcon:MovieClip = null;
      
      public var defendingHQIcon:MovieClip = null;
      
      private var _currentState:String = "";
      
      protected var _iconsDictionary:Dictionary;
      
      private var _disposed:Boolean = false;
      
      public function Icons()
      {
         this._iconsDictionary = new Dictionary();
         super();
         this._iconsDictionary[RADIAL_MENU_CONSTS.SOS] = this.sosIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.RELOAD] = this.reloadIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.NO] = this.noIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.YES] = this.yesIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.HELP_ME_EX] = this.helpmeexIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.SUPPORTING_ALLY] = this.supportingAllyIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.TURN_BACK] = this.turnbackIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.THANK_YOU] = this.thankYouIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.GOING_THERE] = this.waypointIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTENTION_TO] = this.attentionIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.SPG_AREA] = this.spgAreaIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACK] = this.supportIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACKING_ENEMY] = this.attackIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.DEFEND_BASE] = this.defendBaseIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.DEFENDING_BASE] = this.defendingBaseIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACK_BASE] = this.attackBaseIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACKING_BASE] = this.attackingBaseIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACK_HQ] = this.attackHQIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.ATTACKING_HQ] = this.attackingHQIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.DEFEND_HQ] = this.defendHQIcon;
         this._iconsDictionary[RADIAL_MENU_CONSTS.DEFENDING_HQ] = this.defendingHQIcon;
      }
      
      public function showIcon(param1:String) : void
      {
         this.hideAll();
         if(this._iconsDictionary[param1] != null)
         {
            this._iconsDictionary[param1].visible = true;
            if(this._currentState != Values.EMPTY_STR)
            {
               this._iconsDictionary[param1].gotoAndStop(this._currentState);
            }
         }
      }
      
      public function setState(param1:String) : void
      {
         this._currentState = param1;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._disposed = true;
         App.utils.data.cleanupDynamicObject(this._iconsDictionary);
         this._iconsDictionary = null;
         this.supportingAllyIcon = null;
         this.turnbackIcon = null;
         this.supportIcon = null;
         this.spgAreaIcon = null;
         this.helpmeexIcon = null;
         this.sosIcon = null;
         this.defendBaseIcon = null;
         this.noIcon = null;
         this.reloadIcon = null;
         this.attackIcon = null;
         this.yesIcon = null;
         this.waypointIcon = null;
         this.attentionIcon = null;
         this.thankYouIcon = null;
         this.attackBaseIcon = null;
         this.defendingBaseIcon = null;
         this.attackingBaseIcon = null;
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function hideAll() : void
      {
         this.supportingAllyIcon.visible = false;
         this.turnbackIcon.visible = false;
         this.supportIcon.visible = false;
         this.spgAreaIcon.visible = false;
         this.helpmeexIcon.visible = false;
         this.sosIcon.visible = false;
         this.defendBaseIcon.visible = false;
         this.noIcon.visible = false;
         this.reloadIcon.visible = false;
         this.attackIcon.visible = false;
         this.yesIcon.visible = false;
         this.waypointIcon.visible = false;
         this.attentionIcon.visible = false;
         this.thankYouIcon.visible = false;
         this.attackBaseIcon.visible = false;
         this.defendingBaseIcon.visible = false;
         this.attackingBaseIcon.visible = false;
         this.attackHQIcon.visible = false;
         this.attackingHQIcon.visible = false;
         this.defendHQIcon.visible = false;
         this.defendingHQIcon.visible = false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
