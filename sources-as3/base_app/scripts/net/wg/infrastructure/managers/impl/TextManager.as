package net.wg.infrastructure.managers.impl
{
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.base.meta.ITextManagerMeta;
   import net.wg.infrastructure.base.meta.impl.TextManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ITextManager;
   import scaleform.gfx.TextFieldEx;
   
   public class TextManager extends TextManagerMeta implements ITextManager, ITextManagerMeta, IDisposable
   {
       
      
      private var _cashedStylesMap:Dictionary = null;
      
      public function TextManager()
      {
         super();
         this._cashedStylesMap = new Dictionary();
      }
      
      public function createTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.embedFonts = true;
         _loc1_.selectable = false;
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._cashedStylesMap);
         this._cashedStylesMap = null;
         super.onDispose();
      }
      
      public function getTextStyleById(param1:String, param2:String) : String
      {
         var _loc3_:RegExp = /%\(\w+\)s/g;
         if(this._cashedStylesMap[param1] == undefined)
         {
            this._cashedStylesMap[param1] = getTextStyleS(param1);
         }
         return this._cashedStylesMap[param1].replace(_loc3_,param2);
      }
      
      public function setDefTextSelection(param1:TextField) : void
      {
         var _loc2_:uint = 4280163867;
         var _loc3_:uint = 4288059015;
         TextFieldEx.setSelectionTextColor(param1,_loc2_);
         TextFieldEx.setSelectionBkgColor(param1,_loc3_);
         TextFieldEx.setInactiveSelectionTextColor(param1,_loc2_);
         TextFieldEx.setInactiveSelectionBkgColor(param1,_loc3_);
      }
   }
}
