package net.wg.gui.rally
{
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
   import net.wg.infrastructure.base.meta.impl.AbstractRallyViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class AbstractRallyView extends AbstractRallyViewMeta implements IAbstractRallyViewMeta, IViewStackContent
   {
       
      
      private var _pyAlias:String;
      
      public function AbstractRallyView()
      {
         super();
      }
      
      public function as_setPyAlias(param1:String) : void
      {
         this._pyAlias = param1;
      }
      
      public function as_getPyAlias() : String
      {
         return this._pyAlias;
      }
      
      public function as_loadBrowser() : void
      {
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
   }
}
