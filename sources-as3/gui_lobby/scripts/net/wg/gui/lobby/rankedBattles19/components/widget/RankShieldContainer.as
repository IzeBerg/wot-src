package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.rankedBattles19.data.RankShieldVO;
   
   public class RankShieldContainer extends MovieClip
   {
       
      
      public var shield:RankShield = null;
      
      private var _rankSize:String = "";
      
      private var _shieldSize:String = "";
      
      private var _shieldData:RankShieldVO = null;
      
      public function RankShieldContainer()
      {
         super();
      }
      
      public function animateState(param1:Function = null, param2:Function = null) : void
      {
         this.shield.animateState(param1,param2);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function getShieldOffset(param1:String) : Number
      {
         if(this._shieldData)
         {
            return this.shield.getShieldOffset(param1);
         }
         return 0;
      }
      
      public function setData(param1:RankShieldVO) : void
      {
         this._shieldData = param1;
         var _loc2_:Boolean = Boolean(this._shieldData);
         visible = _loc2_;
         if(_loc2_)
         {
            this.shield.setData(this._shieldData);
         }
      }
      
      public function updateSize(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         if(RANKEDBATTLES_ALIASES.WIDGET_SIZES.indexOf(param1) == Values.DEFAULT_INT)
         {
            return;
         }
         if(this._rankSize != param1)
         {
            _loc2_ = param1 != this._rankSize;
            if(!_loc2_)
            {
               return;
            }
            this._rankSize = param1;
            _loc3_ = RANKEDBATTLES_ALIASES.WIDGET_MEDIUM;
            if(RANKEDBATTLES_ALIASES.SHIELD_HUGE_SIZES.indexOf(param1) != Values.DEFAULT_INT)
            {
               _loc3_ = RANKEDBATTLES_ALIASES.WIDGET_HUGE;
            }
            if(_loc2_)
            {
               gotoAndStop(this._rankSize);
               if(this._shieldData)
               {
                  this.shield.setData(this._shieldData);
               }
               if(_loc3_ != this._shieldSize)
               {
                  this._shieldSize = _loc3_;
                  this.shield.updateSize(_loc3_);
               }
            }
         }
      }
      
      protected function onDispose() : void
      {
         stop();
         this.shield.dispose();
         this.shield = null;
         this._shieldData = null;
      }
   }
}
