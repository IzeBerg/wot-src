package net.wg.gui.battle.historicalBattles.minimap.components.entries
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class HBArrowContainer extends MovieClip implements IDisposable
   {
      
      private static const BLINK_START_FRAME:int = 1;
       
      
      public var mc:MovieClip = null;
      
      public var mcBottom:MovieClip = null;
      
      public var mcTop:MovieClip = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _baseDisposed:Boolean = false;
      
      public function HBArrowContainer()
      {
         this._atlasManager = App.atlasMgr;
         super();
         stop();
      }
      
      public final function dispose() : void
      {
         this._baseDisposed = true;
         this.mcBottom = null;
         this.mc = null;
         this.mcTop = null;
         this._atlasManager = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function setBlinking() : void
      {
         gotoAndPlay(BLINK_START_FRAME);
      }
      
      public function setIcon(param1:String) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mc.graphics,Values.EMPTY_STR,true,false,false);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mcBottom.graphics,Values.EMPTY_STR,true,false,false);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mcTop.graphics,Values.EMPTY_STR,true,false,false);
      }
   }
}
