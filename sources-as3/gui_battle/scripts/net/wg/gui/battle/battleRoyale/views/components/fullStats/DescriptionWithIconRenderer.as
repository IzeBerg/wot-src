package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.data.DescriptionBlockWithIconVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class DescriptionWithIconRenderer extends Sprite implements IUpdatable, IDisposable
   {
       
      
      public var icon:BattleAtlasSprite = null;
      
      public var descriptionTF:TextField = null;
      
      protected var iconPostfix:String = "";
      
      private var _baseDisposed:Boolean = false;
      
      public function DescriptionWithIconRenderer()
      {
         super();
         this.icon.isCentralize = true;
      }
      
      protected function onDispose() : void
      {
         this.icon = null;
         this.descriptionTF = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:DescriptionBlockWithIconVO = null;
         if(param1 != null)
         {
            _loc2_ = param1 as DescriptionBlockWithIconVO;
            if(_loc2_ != null)
            {
               if(this.descriptionTF)
               {
                  this.descriptionTF.text = _loc2_.description;
               }
               this.icon.imageName = _loc2_.icon + this.iconPostfix;
               this.icon.blendMode = _loc2_.blendMode;
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + DescriptionBlockWithIconVO);
            }
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
